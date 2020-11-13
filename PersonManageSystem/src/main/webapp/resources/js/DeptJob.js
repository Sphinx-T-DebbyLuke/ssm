$(function(){
	$("#nodataimg").fadeIn(1000);
		$("a[id='DeptJobSelect']").click(function(){
			$("div[id='DeptJobAdd']").hide();
			$("div[id='DeptJobSelect']").fadeIn(1000);
		});
		$("#DeptJobAdd").click(function(){
			$("div[id='DeptJobSelect']").hide();
			$("div[id='DeptJobAdd']").show(1000);
		});
		$("#resetDeptJob").click(function(){
			$("#table2 input[name='name']").val(null);
			$("textarea[name='remark']").val(null);
		});
		$("select[name='perPageSize']").change(function(){
			var $perPageSize=$("select[name='perPageSize'] option:selected").val();
			$("#form1 input[name='perPageSize']").val($perPageSize);
		});
		$("#buttonaddDeptJob").click(function(){
			var name=$("#table2 input[name='name']").val().trim();
			if(name==""){
				$(".alert,alert-danger").show();
				$(".alert,alert-danger").fadeOut(4000);
				return false;
			}
			return true;
		});
		$("#updateDeptJob").click(function(){
			$.post("updateDeptJobInfo.action",$("#edit_DeptJob_form").serialize(),
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
			$("input[id='diaglogtxtsubbutton']").click(function(){
				$.post("deleteDeptJobInfo.action",$("#formbydelete").serialize(),function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
	});
function editDeptJob(id,tableName){
	$.post("getDeptJobById.action", { id: id,tableName:tableName},
	  function(data){
	    $("#edit_id").val(data.id);
	    $("#edit_Name").val(data.name);
	    $("#edit_remark").val(data.remark);
	    if(data.salary!=''){
	    	$("#edit_Salary").val(data.salary);
	    }
	 });
}
function deleteByoneid(id,tableName){
	$("#diaglogtxt").html("你确定要删除吗？");
	$("input[id='diaglogtxtsubbutton']").click(function(){
		$.post("deleteDeptJobInfo.action",{ids:id,tableName:tableName},function(data){
			window.location.reload();
		});
	});
	$("#errorDialog").modal("show");
}