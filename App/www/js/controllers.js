angular.module('starter.controllers', [])

.controller('1x1Ctrl', function ($scope) {
    $scope.random = Math.floor((Math.random() * 1000000)) + "";
    while($scope.random.length != 6){
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
    }
    $scope.input = '';
    $scope.press = function (value) {
        var x = value + '';
        $scope.input += x;
        if ($scope.input.length == 7) {
            $scope.input = '';
        }
    }
    $scope.check = function () {
        if ($scope.input == $scope.random) {
            $scope.random = 'Correct PIN';
            $scope.input = '';
        } else {
            $scope.random = 'Incorrect PIN';
            $scope.input = '';
        }
    }
    $scope.newpin = function () {
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
        while ($scope.random.length != 6) {
            $scope.random = Math.floor((Math.random() * 1000000)) + "";
        }
    };
})

.controller('2x2Ctrl', function ($scope, Chats) {
    $scope.random = Math.floor((Math.random() * 1000000)) + "";
    while ($scope.random.length != 6) {
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
    }
    $scope.input = '';
    $scope.press = function (value) {
        var x = value + '';
        $scope.input += x;
        if ($scope.input.length == 7) {
            $scope.input = '';
        }
    }
    $scope.check = function () {
        if ($scope.input == $scope.random) {
            $scope.random = 'Correct PIN';
            $scope.input = '';
        } else {
            $scope.random = 'Incorrect PIN';
            $scope.input = '';
        }
    }
    $scope.newpin = function () {
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
        while ($scope.random.length != 6) {
            $scope.random = Math.floor((Math.random() * 1000000)) + "";
        }
    };
})

.controller('4x4Ctrl', function ($scope) {
    $scope.random = Math.floor((Math.random() * 1000000)) + "";
    while ($scope.random.length != 6) {
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
    }
    $scope.input = '';
    $scope.press = function (value) {
        var x = value + '';
        $scope.input += x;
        if ($scope.input.length == 7) {
            $scope.input = '';
        }
    }
    $scope.check = function () {
        if ($scope.input == $scope.random) {
            $scope.random = 'Correct PIN';
            $scope.input = '';
        } else {
            $scope.random = 'Incorrect PIN';
            $scope.input = '';
        }
    }
    $scope.newpin = function () {
        $scope.random = Math.floor((Math.random() * 1000000)) + "";
        while ($scope.random.length != 6) {
            $scope.random = Math.floor((Math.random() * 1000000)) + "";
        }
    };
});
