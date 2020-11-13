$(function(){
	$("#nodataimg").fadeIn(1000);
		$("a[id='DocumentSelect']").click(function(){
			$("div[id='DocumentAdd']").hide();
			$("div[id='DocumentSelect']").fadeIn(1000);
		});
		$("#DocumentAdd").click(function(){
			$("div[id='DocumentSelect']").hide();
			$("div[id='DocumentAdd']").show(1000);
		});
		$("#resetDocument").click(function(){
			$("#table2 input[name='title']").val(null);
			$("textarea[name='content']").val(null);
		});
		$("select[name='perPageSize']").change(function(){
			var $perPageSize=$("select[name='perPageSize'] option:selected").val();
			$("#form1 input[name='perPageSize']").val($perPageSize);
		});
		$("#buttonaddDocument").click(function(){
			var name=$("#table2 input[name='title']").val().trim();
			if(name==""){
				$(".alert,alert-danger").show();
				$(".alert,alert-danger").fadeOut(4000);
				return false;
			}
			return true;
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
		$(".mytooltip").mouseenter(function(){
			$(".text-muted").text($(this).html());
			$(this).addClass("mousetable");
		});
		$(".mytooltip").mouseleave(function(){
			$(".text-muted").text("");
			$(this).removeClass("mousetable");
		});
		$("#edit_update").click(function(){
			$.post("UpdateDocu.action",$("#edit_document_form").serialize(),
			function(data){
				window.location.reload();
			});
		});
		$("#selectalldelete").click(function(){
			if($(this).prop("checked")){
				$("#alldeleteBychecked").show();
				$("input[name='ids']").prop("checked",true);
				$("input[name='filenameList']").prop("checked",true);
			}else{
				$("#alldeleteBychecked").hide();
				$("input[name='ids']").removeAttr("checked");
				$("input[name='filenameList']").removeAttr("checked");
			}
		});
		$("input[name='ids']").click(function(){
			if($(this).prop("checked")){
				$(this).parent().siblings("#filenameList").children("input[name='filenameList']").prop("checked",true);
				$("#alldeleteBychecked").show();
			}else if($("input[name='ids']:checked").length<1){
				$("#selectalldelete").removeAttr("checked");
				$("#alldeleteBychecked").hide();
				$(this).parent().siblings("#filenameList").children("input[name='filenameList']").removeAttr("checked");
			}else if(!$(this).prop("checked")){
				$(this).parent().siblings("#filenameList").children("input[name='filenameList']").removeAttr("checked");
			}
		});
		$("#alldeleteBychecked").click(function(){
			$("#diaglogtxt").html("你确定要删除吗？");
			$("input[id='diaglogtxtsubbutton']").bind("click",function(){
				$.post("DeleteDocuByIds.action",$("#formbydelete").serialize(),function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
		$("a[name='deleteByoneid']").click(function(){
			var id=$(this).parent().siblings().children("input[name='ids']").val();
			var filename=$(this).parent().siblings("#filenameList").children("input[name='filenameList']").val();
			$("#diaglogtxt").html("你确定要删除吗？");
			$("input[id='diaglogtxtsubbutton']").bind("click",function(){
				$.post("DeleteDocuByIds.action",{ids:id,filenameList:filename},function(data){
					window.location.reload();
				});
			});
			$("#errorDialog").modal("show");
		});
	});
function editdocument(id){
	$.post("CheckDocuById.action", { id: id},
	  function(data){
	    $("#edit_document_id").val(data.id);
	    $("#edit_title").val(data.title);
	    $("#edit_oldfilename").val(data.filename);
	    $("#edit_newfilename").val(data.filename);
	    $("#edit_remark").val(data.remark);
	 });
}