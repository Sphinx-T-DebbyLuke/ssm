$(function(){
	$("#nodataimg").fadeIn(1000);
		$("a[id='UserSelect']").click(function(){
			$("div[id='UserAdd']").hide();
			$("div[id='UserSelect']").fadeIn(1000);
		});
		$("#UserAdd").click(function(){
			$("div[id='UserSelect']").hide();
			$("div[id='UserAdd']").show(1000);
		});
		$("#resetUser").click(function(){
			$("#table2 input[name='loginname']").val(null);
			$("#table2 input[name='password']").val(null);
			$("#table2 select[name='username']>option").removeAttr("selected");
		});
		$("select[name='perPageSize']").change(function(){
			var $perPageSize=$("select[name='perPageSize'] option:selected").val();
			$("#form1 input[name='perPageSize']").val($perPageSize);
		});
		var repeatOrNo=false;
		$("#buttonaddUser").click(function(){
			if(repeatOrNo){
				var loginname=$("#table2 input[name='loginname']").val().trim();
				var password=$("#table2 input[name='password']").val().trim();
				var selected=$("#table2 select[name='username']>option:selected").val()=='';
				if(loginname==""||password==""||selected){
					$("#diaglogtxt").html("所传参数不能为空！");
					$("input[id='diaglogtxtsubbutton']").unbind("click");
					$("input[id='diaglogtxtsubbutton']").attr("data-dismiss","modal");
					$("#errorDialog").modal("show");
					return false;
				}
				return true;
			}
			return false;
		});
		$("#toRegisterByloginname").focusout(function(){
			//获取路径
			var pathName=window.document.location.pathname;
			//截取，得到项目名称
			var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
			var $loginname=$("#toRegisterByloginname").val().trim();
			$.get(projectName+"/User/checkLoginnameRepeat.action", { loginname: $loginname },
  			function(data){
    			if(data=="false"){
    				$("#diaglogtxt").html("该用户有重复！");
					$("input[id='diaglogtxtsubbutton']").unbind("click");
					$("input[id='diaglogtxtsubbutton']").attr("data-dismiss","modal");
					$("#errorDialog").modal("show");
    				repeatOrNo=false;
    			}else if(data=="success"){
    				$("#toRegisterByloginname").removeAttr("data-original-title");
    				repeatOrNo=true;
    			}
  			});
		});
		window.setInterval(function() {
			$.get("getDymicStatus.action", function(data){
  				$.each(data,function(i,n){
  					var $status="离线";
  					if(this.userstatus==2){
  						$status="<font style='font-weight: bold;color: green;'>在线</font>";
  					}
  					$("td[id='"+this.id+"']").parent().children("#dymicStatus").html($status);
  				});
			});
		}, 1500);
		$("#edit_update").click(function(){
			$.post("updateUserInfo.action",$("#edit_User_form").serialize(),
			function(data){
				window.location.reload();
			});
		});
		$("#selectalldelete").click(function(){
			if($(this).prop("checked")){
				$("#alldeleteBychecked").show();
				$("input[name='ids']").prop("checked",true);
			}else{
				$("#alldeleteBychecked").hide();
				$("input[name='ids']").removeAttr("checked");
			}
		});
		$("input[name='ids']").click(function(){
			if($(this).prop("checked")){
				$("#alldeleteBychecked").show();
			}else if($("input[name='ids']:checked").length<1){
				$("#selectalldelete").removeAttr("checked");
				$("#alldeleteBychecked").hide();
			}
		});
		$("#alldeleteBychecked").click(function(){
			$("#diaglogtxt").html("你确定要删除吗？");
			$("input[id='diaglogtxtsubbutton']").bind("click",function(){
				$.post("deleteUserInfo.action",$("#formbydelete").serialize(),function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
	});
	function editUser(id){
		$.post("getUserById.action", { id: id},
  		function(data){
    		$("#edit_id").val(data.id);
    		$("#edit_Name").val(data.loginname);
    		$("#edit_password").val(data.password);
    		$("#edit_userstatus").val(data.userstatus);
    		$("#edit_createdate").val(data.createdateStr);
    		$("#edit_From>option[value='"+data.username+"']").prop("selected",true);
    		$("#emp_id>option[value='"+data.emp_id+"']").prop("selected",true);
  		});
	}
	function deleteByoneid(id){
		$("#diaglogtxt").html("你确定要删除该用户吗？");
		$("input[id='diaglogtxtsubbutton']").bind("click",function(){
			$.post("deleteUserInfo.action",{ids:id},function(data){
				window.location.reload();
			});
		});
		$("#errorDialog").modal("show");
	}