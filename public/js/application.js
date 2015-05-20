var app;
var app = angular.module('tweetFinder', ['ngResource', 'ngRoute']);

app.factory('instagram', ['$resource',
  function($resource){
    return $resource('/instagram/:location', {}, {
      query: {method:'GET', params:{location: "location"}, isArray: true }
    });
  }]);
app.controller('MapController', function($http, $scope, instagram, $interval, $timeout) {
    controller = this
    $scope.instagrams = [];
    $scope.locationInput = "New York City"
    $scope.loadData = function() {
      instagram.query({location: $scope.locationInput}, function(instagrams){
        $scope.instagrams = instagrams;
        $scope.featuredInstagram = $scope.instagrams[0];
      });
    };
    $scope.setLocation = function() {
      $scope.location = $scope.locationInput;
    };
    $scope.changedFeatured = function(instagram) {
      $scope.featuredInstagram = instagram;
    }
})
.directive('formage', function() {
  return {
    restrict: 'E',
    templateUrl: 'partials/formage.erb'
  };
})
.directive('list', function() {
  return {
    restrict: 'E',
    templateUrl: 'partials/list.erb'
  };
})
.directive('profile', function() {
  return {
    restrict: 'E',
    templateUrl: 'partials/profile.erb'
  };
})