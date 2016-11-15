#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/usb.h>
 
#define MIN(a,b) (((a) <= (b)) ? (a) : (b))
#define BULK_EP_OUT 0x04
#define BULK_EP_IN 0x83
#define MAX_PKT_SIZE 512

#define DRIVER_AUTHOR "OskrD"
#define DRIVER_DESC "Serial control for a mechanical finger on Arduino platform"

#define VENDOR_ID 0x2341
#define PRODUCT_ID 0x0043

 
static struct usb_device *device;
static struct usb_class_driver class;
static unsigned char bulk_buf[MAX_PKT_SIZE];

static int arduino_probe(struct usb_interface *interface, const struct usb_device_id *id);
static void arduino_disconnect(struct usb_interface *interface);

 
MODULE_LICENSE("GPL");
MODULE_AUTHOR(DRIVER_AUTHOR);
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_VERSION("0.6.9");

 
static int arduino_open(struct inode *i, struct file *f)
{
    printk("Open()\n");
    return 0;
}
static int arduino_close(struct inode *i, struct file *f)
{
    printk("Close()\n");
    return 0;
}


static ssize_t arduino_write(struct file *f, const char __user *buf, size_t cnt, loff_t *off)
{
    int retval;
	char value[2];
    int wrote_cnt = MIN(cnt, MAX_PKT_SIZE);
 
    if (copy_from_user(bulk_buf, buf, MIN(cnt, MAX_PKT_SIZE)))
    {
        return -EFAULT;
    }
 	value[1] = bulk_buf[0];
    /* Write the data into the bulk endpoint */
    retval = usb_bulk_msg(device, usb_sndbulkpipe(device, BULK_EP_OUT),
            value, 2, &wrote_cnt, 9600);
    printk("Bulk message sent in %d, %s, size %zu, returned %d\n", BULK_EP_OUT, bulk_buf, cnt, wrote_cnt);
    if (retval)
    {
        printk("Bulk message returned %d\n", retval);
        return retval;
    }
 
    return wrote_cnt;
}

 
static struct file_operations fops =
{
    .open = arduino_open,
    .release = arduino_close,
    .write = arduino_write,
};
 
static int arduino_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
    int retval;
 
    device = interface_to_usbdev(interface);
 
    class.name = "usb/arduino%d";
    class.fops = &fops;
    if ((retval = usb_register_dev(interface, &class)) < 0)
    {
        /* Something prevented us from registering this driver */
        printk("Not able to get a minor for this device\n");
    }
    else
    {
        printk("Minor obtained: %d\n", interface->minor);
    }
 
    return retval;
}
 
static void arduino_disconnect(struct usb_interface *interface)
{
    usb_deregister_dev(interface, &class);
}
 
/* Table of devices that work with this driver */
static struct usb_device_id arduino_table[] =
{
    { USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
    {} /* Terminating entry */
};
MODULE_DEVICE_TABLE (usb, arduino_table);
 
static struct usb_driver arduino_driver =
{
    .name = "arduino_driver",
    .probe = arduino_probe,
    .disconnect = arduino_disconnect,
    .id_table = arduino_table,
};
 
static int __init arduino_init(void)
{
    int result;
 
    /* Register this driver with the USB subsystem */
    if ((result = usb_register(&arduino_driver)))
    {
	printk("usb_register failed. Error number %d\n", result);
    }
    return result;
}
 
static void __exit arduino_exit(void)
{
    /* Deregister this driver with the USB subsystem */
    usb_deregister(&arduino_driver);
}
 
module_init(arduino_init);
module_exit(arduino_exit);

