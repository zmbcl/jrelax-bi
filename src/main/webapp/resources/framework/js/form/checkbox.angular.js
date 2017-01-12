ns.ready(function(){
	ns.angularJS.iCheck = {
			init : function(){
				//模块化
				if(angular){
					ns.angularJS.app.directive('ngIcheck', function($compile) {
				        return {
				                restrict : 'A',
				                require : '?ngModel',
				                link : function($scope, $element, $attrs, $ngModel) {
				                        if (!$ngModel) {
				                                return;
				                        }
				                        //using iCheck
				                        $($element).iCheck({
				                                labelHover : false,
				                                cursor : true,
				                                checkboxClass : 'icheckbox',
				                                radioClass : 'iradio',
				                                increaseArea : '20%'
				                        }).on('ifClicked', function(event) {
				                                if ($attrs.type == "checkbox") {
				                                        //checkbox, $ViewValue = true/false/undefined
				                                        $scope.$apply(function() {
				                                                $ngModel.$setViewValue(!($ngModel.$modelValue == undefined ? false : $ngModel.$modelValue));
				                                        });
				                                } else {
				                                        // radio, $ViewValue = $attrs.value
				                                        $scope.$apply(function() {
				                                                $ngModel.$setViewValue($attrs.value);
				                                        });
				                                }
				                        });
				                },
				        };
					});
				}
			}
	};
	try{
		if(!ns.angularJS.app)
			ns.angularJS.init();
		ns.angularJS.iCheck.init();
	}catch(e){
		alert("请引入icheck组件！"+e);
	}
});