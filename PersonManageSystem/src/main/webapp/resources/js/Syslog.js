$(function(){
	$("#nodataimg").fadeIn(1000);
	$("select[name='perPageSize']").change(function(){
		var $perPageSize=$("select[name='perPageSize'] option:selected").val();
		$("#form1 input[name='perPageSize']").val($perPageSize);
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
		$("#diaglogtxt").html("你确定要删除吗？");
		$("input[id='diaglogtxtsubbutton']").bind("click",function(){
			$.post("DeleteNotByIds.action",$("#formbydelete").serialize(),function(data){
				window.location.reload();
			});
		});
		$("#errorDialog").modal("show");
	});
});