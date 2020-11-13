
	$(function() {
		var pp=true;
		window.setTimeout(function(){
			signFun();
        	var currentMon=$("#currentMon").val();//当前月的天数
        	//获取路径
        	var pathName=window.document.location.pathname;
        	//截取，得到项目名称
        	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
        	$.post(projectName+"/User/getSalary.action",{ currentMon: currentMon}, function(data){
        		$("#dataString").val(data.nowdataString);
        		if(data.nowdataString.search(new Date().getDate())!=-1){
        			$("#js-just-qiandao").addClass('actived');
        			$("#js-just-qiandao").unbind("click");
        			$("#qiandao-notic2").hide();
        			$("#qiandao-notic1").show();
        		}
        		$("#qiandaoNum").html(data.qiandaoNum+" 天");
        		$("#salary").html(data.salary+" 元");
        		signFun();
        	});
        });
		function signFun() {

	        var dateArray = $("#dataString").val().split(","); // 自定义一个数组，用于显示在列表上事先已经签到的日期

	        var $dateBox = $("#js-qiandao-list"), //获取ul列表
	            $currentDate = $(".current-date"), //用于显示当前时间
	            $qiandaoBnt = $("#js-just-qiandao"), //获取右上侧签到按钮
	            _html = '',
	            _handle = true, //这个_handle是自定义的属性，用于表面右上侧的签到按钮状态，如果handle是true，则表面可以签到。
	            myDate = new Date(); //获取当前时间
	        $currentDate.text(myDate.getFullYear() + '年' + (myDate.getMonth() + 1) + '月' + myDate.getDate() + '日');
	        // 因为getMonth是从0开始计算的，myDate.getMonth()输出的结果是当前月份-1，所以实际使用时需要+1
	        var monthFirst = new Date(myDate.getFullYear(), (myDate.getMonth()), 1).getDay();
	        // 这个属性用于用于显示当前月份第一天是星期几，例如9月第一天是星期四，所以生成的li列表要从星期四开始算起，前面的四个li是空置的。
	        // 这里计算当前月份的第一天是星期几，不需要在getMonth上+1。如果是在括号里面加上引号的话，那就需要+1，这点大家可以试一下，具体原因我也不是很确定
	        var d = new Date(myDate.getFullYear(), myDate.getMonth() + 1, 0);
	        var totalDay = d.getDate(); //获取当前月的天数
	        $("#currentMon").val(totalDay);
	        for (var i = 0; i < 42; i++) {
	            _html += ' <li><div class="qiandao-icon"></div></li>';
	            //用于动态创建li列表，并且在每个li中都要生成一个div用于显示签到的那个状态(就是那个绿色的圈圈)
	            //生成的li和div大小都是一样的，并且div的层级要比li高，但是初始状态是display:none;在签到之后显示block，这样这个绿色圈圈就会覆盖在li上面就是我们看到的情况。
	        }
	        $dateBox.html(_html) //动态生成日历网格
	        var $dateLi = $dateBox.find("li");
	        for (var i = 0; i < totalDay; i++) {
	            $dateLi.eq(i + monthFirst).addClass("date" + (i + 1));
	            //这里可以看出monthFirst的作用，让列表从0+4个位置开始(当前9月份从星期四开始)，并且给每个li添加Class，这个Class时在CSS忠设置好的，也是用的CSS Spirite
	            if($("#dataString").val()!=""){
	            	for (var j = 0; j < dateArray.length; j++) {
		                if (i == dateArray[j]) {
		                    $dateLi.eq(i-1 + monthFirst).addClass("qiandao");
		            //两者进行匹配。如果相等则给当前li添加Class，即显示li里面的Div层
		                }
		            }
	            }
	        } //生成当月的日历且含已签到

	        $(".date" + myDate.getDate()).addClass('able-qiandao');
	        //这个是用于给当前li添加“可以签到”属性，下面的代码是假如当前li具备这个属性且右上侧的按钮处于可以点击状态，则可以直接在日历上点击进行签到
	        if(pp){
	        	
	        	
	        $dateBox.on("click", "li", function() {
	                if ($(this).hasClass('able-qiandao') && _handle) {
	                    $(this).addClass('qiandao');
	                    qiandaoFun();
	                }
	            }) 
	            
	        $qiandaoBnt.bind("click", function() {
	            if (_handle) {
	                qiandaoFun();
	            }
	        }); //点击签到按钮进行签到

	        function qiandaoFun() {
	            $qiandaoBnt.addClass('actived');
	            openLayer("qiandao-active", qianDao);
	            _handle = false;
	        }//签到函数，签到完成之后按钮显示已经签到，并且调用弹窗函数

	        function qianDao() {
	            $(".date" + myDate.getDate()).addClass('qiandao');
	            var myarr=$("#dataString").val().split(",");
	            myarr.push(myDate.getDate());
	            var nowdataString;
	            if($("#dataString").val()!=""){
	            	nowdataString=myarr.join(",");
	            }else{
	            	nowdataString=myDate.getDate();
	            }
	            var currentMon=$("#currentMon").val();//当前月的天数
            	//获取路径
            	var pathName=window.document.location.pathname;
            	//截取，得到项目名称
            	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
            	$.post(projectName+"/User/UpdateSalary.action",{ currentMon: currentMon,nowdataString:nowdataString},function(data){
            		$("#dataString").val(data.nowdataString);
            		$("#qiandaoNum").html(data.qiandaoNum+" 天");
            		$("#salary").html(data.salary+" 元");
            		$("#qiandao-notic2").hide();
            		$("#qiandao-notic1").show();
            		signFun();
            	});
            	
            	}//在列表上显示已经签到的状态
	    };

	    
	    function openLayer(a, Fun) {
	        $('.' + a).fadeIn(Fun);
	    } //定义一个弹窗函数

	    var closeLayer = function() {
	            $("body").on("click", ".close-qiandao-layer", function() {
	                $(this).parents(".qiandao-layer").fadeOut()
	            })
	        }() //关闭弹窗按钮

	    $("#js-qiandao-history").on("click", function() {
	        openLayer("qiandao-history-layer", myFun);
	        function myFun() {
	            return
	        } //已经签到的天数，点击显示弹窗
	    });
	        
	        
	        pp=false;
		}
});

	