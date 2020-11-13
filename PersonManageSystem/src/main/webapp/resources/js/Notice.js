$(function(){
	$("#nodataimg").fadeIn(1000);
		$("a[id='NoticeSelect']").click(function(){
			$("div[id='NoticeAdd']").hide();
			$("div[id='NoticeSelect']").fadeIn(1000);
		});
		$("#NoticeAdd").click(function(){
			$("div[id='NoticeSelect']").hide();
			$("div[id='NoticeAdd']").show(1000);
		});
		$("#resetNotice").click(function(){
			$("#table2 input[name='title']").val(null);
			$("textarea[name='content']").val(null);
		});
		$("select[name='perPageSize']").change(function(){
			var $perPageSize=$("select[name='perPageSize'] option:selected").val();
			$("#form1 input[name='perPageSize']").val($perPageSize);
		});
		$("#buttonaddNotice").click(function(){
			var name=$("#table2 input[name='title']").val().trim();
			if(name==""){
				$(".alert,alert-danger").show();
				$(".alert,alert-danger").fadeOut(4000);
				return false;
			}
			return true;
		});
		$("#edit_update").click(function(){
			$.post("NotUpdate.action",$("#edit_notice_form").serialize(),
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
				$.post("DeleteNotByIds.action",$("#formbydelete").serialize(),function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
	});
function editNotice(id){
	$.post("CheckNotById.action", { id: id},
	  function(data){
	    $("#edit_notice_id").val(data.id);
	    $("#edit_title").val(data.title);
	    $("#edit_content").val(data.content);
	 });
}
function deleteByoneid(id){
	$("#diaglogtxt").html("你确定要删除吗？");
	$("input[id='diaglogtxtsubbutton']").bind("click",function(){
		$.post("DeleteNotByIds.action",{ids:id},function(data){
			window.location.reload();
		});
	});
	$("#errorDialog").modal("show");
}