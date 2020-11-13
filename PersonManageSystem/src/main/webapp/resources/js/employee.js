$(function(){
	$("#nodataimg").fadeIn(1000);
		$("a[id='EmpSelect']").click(function(){
			$("#listordetail").text("员工查询");
			$("#empdetail").hide();
			$("input[value='更改信息']").hide();
			$("div[id='EmpAdd']").hide();
			$("div[id='EmpSelect']").fadeIn(1000);
		});
		$("#EmpAdd").click(function(){
			$("#empdetail").hide();
			$("div[id='EmpSelect']").hide();
			$("div[id='EmpAdd']").show(1000);
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
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
			$("#errorDialog .modal-body>center").html("<p style='color:red'>你确定要删除吗？</p>");
			$("input[id='diaglogtxtsubbutton']").bind("click",function(){
				$.post("EmpDeleteByIds.action",$("#formbydelete").serialize(),function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
		
		$(".img-circle").click(function(){
			$("input[type='file']").click();
		});
		$("input[type='file']").change(function(){
			var file=this.files[0];
			var url=window.URL.createObjectURL(file);
			$(".img-circle").attr("src",url);
		});
		$("#emptabletoUpdate").keydown(function(){
			$("input[value='更改信息']").fadeIn(1000);
		});
		$("#ee_sex,#ee_dept_id,#ee_job_id,#ee_jobstatus").change(function(){
			$("input[value='更改信息']").fadeIn(1000);
		});
		$("input[type='file']").click(function(){
			$("input[value='更改信息']").fadeIn(1000);
		});
		$("input[value='更改信息']").click(function(){
			$("input[id='diaglogtxtsubbutton']").unbind("click");
			var $name=$("#ee_name").val().trim();
			var $birthday=$("#ee_birthday").val().trim();
			var $phone=$("#ee_phone").val().trim();
			var $email=$("#ee_email").val().trim();
			var $address=$("#ee_address").val().trim();
			var $card_id=$("#ee_card_id").val().trim();
			var $sex=$("#ee_sex>option:selected").val()=='';
			var $jobstatus=$("#ee_jobstatus>option:selected").val()=='';
			var $dept_id=$("#ee_dept_id>option:selected").val()=='';
			var $job_id=$("#ee_job_id>option:selected").val()=='';
			var tagsize=$("#errorDialog .modal-body>center");
			var gg=true;
			gg=verallstyle($name,$card_id,$address,$phone,$email,$birthday,$sex,$dept_id,$job_id,tagsize);
			if($jobstatus){
				if(tagsize.children(".jobstatus").length<1){
					$("#errorDialog .modal-body>center").append("<p class='jobstatus' style='color: red;'>请确认在职状态！</p>");
				}
				gg=false;
				$("#errorDialog").modal("show");
			}
			if(gg){
				$("#edit_emp_form").submit();
			}else{
				$("input[id='diaglogtxtsubbutton']").attr("data-dismiss","modal");
			}
		});
		
		$("#resetEmp").click(function(){
			$("#table2 input[name='name']").val(null);
			$("#table2 input[name='card_id']").val(null);
			$("#table2 input[name='education']").val(null);
			$("#table2 input[name='email']").val(null);
			$("#table2 input[name='phone']").val(null);
			$("#table2 input[name='tel']").val(null);
			$("#table2 input[name='race']").val(null);
			$("#table2 input[name='party']").val(null);
			$("#table2 input[name='qq_num']").val(null);
			$("#table2 input[name='hobby']").val(null);
			$("#table2 input[name='post_code']").val(null);
			$("#table2 input[name='speciality']").val(null);
			$("#table2 input[name='birthday']").val(null);
			$("#table2 input[name='address']").val(null);
			$("#table2 input[name='remark']").val(null);
			$("#table2 select[name='sex']>option").removeAttr("selected");
			$("#table2 select[name='job.id']>option").removeAttr("selected");
			$("#table2 select[name='dept.id']>option").removeAttr("selected");
		});
		$("select[name='perPageSize']").change(function(){
			var $perPageSize=$("select[name='perPageSize'] option:selected").val();
			$("#form1 input[name='perPageSize']").val($perPageSize);
		});
		$("#buttonaddEmp").click(function(){
			$("input[id='diaglogtxtsubbutton']").unbind("click");
			var $name=$("#table2 input[name='name']").val().trim();
			var $card_id=$("#table2 input[name='card_id']").val().trim();
			var $address=$("#table2 input[name='address']").val().trim();
			var $phone=$("#table2 input[name='phone']").val().trim();
			var $email=$("#table2 input[name='email']").val().trim();
			var $birthday=$("#table2 input[name='birthday']").val().trim();
			var $sex=$("#table2 select[name='sex']>option:selected").val()=='';
			var $dept_id=$("#table2 select[name='dept.id']>option:selected").val()=='';
			var $job_id=$("#table2 select[name='job.id']>option:selected").val()=='';
			var tagsize=$("#errorDialog .modal-body>center");
			$("input[id='diaglogtxtsubbutton']").attr("data-dismiss","modal");
			var gg=true;
			gg=verallstyle($name,$card_id,$address,$phone,$email,$birthday,$sex,$dept_id,$job_id,tagsize);
			return gg;
		});
		
		$("[data-toggle='tooltip']").tooltip();//提示工具
	});
function deleteEmpByid(id){
	$("#errorDialog .modal-body>center").html("<p style='color:red'>你确定要删除该员工吗？</p>");
	$("input[id='diaglogtxtsubbutton']").bind("click",function(){
		$.post("EmpDeleteByIds.action",{ids:id},function(data){
			window.location.reload();
		});
	});
	$("#errorDialog").modal("show");
}
function editEmpByid(id){
	$("#listordetail").text("返回列表").click(function(){
		$("#ee_sex>option").removeAttr("selected");
		$("#ee_jobstatus>option").removeAttr("selected");
		$("#ee_job_id>option").removeAttr("selected");
		$("#ee_dept_id>option").removeAttr("selected");
	});
	$("div[id='EmpSelect']").hide();
	$("#empdetail").slideDown("slow");
	//获取路径
	var pathName=window.document.location.pathname;
	//截取，得到项目名称
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	$.post("CheckEmpById.action", { id: id},
		function(data){
		$("#ee_id").val(data.id);
		$("#ee_name").val(data.name);
		$("#ee_sex>option[value='"+data.sex+"']").prop("selected",true);
		$("#ee_jobstatus>option[value='"+data.jobstatus+"']").prop("selected",true);
		$("#ee_job_id>option[value='"+data.job.id+"']").prop("selected",true);
		$("#ee_dept_id>option[value='"+data.dept.id+"']").prop("selected",true);
		$("#ee_party").val(data.party);
		$("#ee_race").val(data.race);
		$("#ee_education").val(data.education);
		$("#ee_birthday").val(data.birthdayStr);
		$("#ee_phone").val(data.phone);
		$("#ee_tel").val(data.tel);
		$("#ee_qq_num").val(data.qq_num);
		$("#ee_email").val(data.email);
		$("#ee_hobby").val(data.hobby);
		$("#ee_speciality").val(data.speciality);
		$("#ee_card_id").val(data.card_id);
		$("#ee_address").val(data.address);
		$("#ee_remark").val(data.remark);
		$("#ee_post_code").val(data.post_code);
		$("#ee_imageUrl").val(data.imageUrl);
		if(data.imageUrl!=null&&data.imageUrl!=""){
			$(".img-circle").attr("src",projectName+"/upload/headimage/"+data.id+"/"+data.imageUrl);
		}else{
			$(".img-circle").attr("src",projectName+"/resources/images/tim.jpg");
		}
	});
}
function verallstyle($name,$card_id,$address,$phone,$email,$birthday,$sex,$dept_id,$job_id,tagsize){
	var kk=true;
	if($name==""||$card_id==""||$address==""||$phone==""||$email==""||$birthday==""||$sex||$dept_id||$job_id){
		$("#errorDialog .modal-body>center").html("<p style='color:red'>*必传参数不能为空！</p>");
		$("#errorDialog").modal("show");
		kk=false;
	}
	var cardvar=/^[0-9]{17}[0-9,x]$/;
	if(!cardvar.test($card_id)){
		if(tagsize.children(".card_id").length<1){
			$("#errorDialog .modal-body>center").append("<p class='card_id' style='color: red;'>身份证格式错误！</p>");
		}
		kk=false;
		$("#errorDialog").modal("show");
	}else if(cardvar.test($card_id)){
		$("#errorDialog .modal-body>center>.card_id").remove();
	}
	var emailver=/^[0-9]+@[a-z,A-Z,0-9]+\.com$/;
	if(!emailver.test($email)){
		if(tagsize.children(".email").length<1){
			$("#errorDialog .modal-body>center").append("<p class='email' style='color: red;'>邮箱格式错误！</p>");
		}
		kk=false;
		$("#errorDialog").modal("show");
	}else if(emailver.test($email)){
		$("#errorDialog .modal-body>center>.email").remove();
	}
	var phonever=/^[0-9]{11}$/;
	if(!phonever.test($phone)){
		if(tagsize.children(".phone").length<1){
			$("#errorDialog .modal-body>center").append("<p class='phone' style='color: red;'>手机号格式错误！</p>");
		}
		kk=false;
		$("#errorDialog").modal("show");
	}else if(phonever.test($phone)){
		$("#errorDialog .modal-body>center>.phone").remove();
	}
	var birthday=/^[0-9]{4}-[0,1][0-9]-[0,1,2,3][0-9]$/;
	if(!birthday.test($birthday)){
		if(tagsize.children(".birthday").length<1){
			$("#errorDialog .modal-body>center").append("<p class='birthday' style='color: red;'>出身年月格式为年-月-日！</p>");
		}
		kk=false;
		$("#errorDialog").modal("show");
	}else if(birthday.test($birthday)){
		$("#errorDialog .modal-body>center>.birthday").remove();
	}
	return kk;
}