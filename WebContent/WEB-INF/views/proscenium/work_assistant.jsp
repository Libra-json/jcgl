<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${path }/static/proscenium/logo/favicon2.ico" /> 
    <link href="${path }/static/proscenium/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${path }/static/proscenium/plugin/bootstrap-tables/bootstrap-table.min.css" />
    <link href="${path }/static/proscenium/plugin/bootstrap-validator/bootstrapValidator.min.css" rel="stylesheet">
    <link href="${path }/static/proscenium/plugin/sweetalert2/sweetalert2.min.css" rel="stylesheet">
    <link href="${path }/static/proscenium/css/style.css" rel="stylesheet">
<title>招生管理公共平台-工作助手</title>
</head>
<body>
<jsp:include page="/static/proscenium/commons/head.jsp"></jsp:include>
<div class="container">
	<h3 style="text-align: center;font-weight: bold;">工作助手</h3>
	<div class="row" style="margin-top: 40px;">
		<div class="col-xs-12">
			<table id="scheduleTable" data-toggle="table"
			       data-url="${path }/schedule/queryBypages?id=${user.id}"
			       data-pagination="true"
			       data-locale="zh-CN"
			       data-side-pagination="server"
			       data-toolbar="#toolbar"
			       data-search="false"
			       data-show-refresh="true"
			       data-show-toggle="true"
			       data-show-columns="true"
			       data-show-export="true" 
			       data-minimum-count-columns="2" 
			       data-id-field="sid" 
			       data-show-footer="false"
			       data-row-style="rowStyle">
			    <thead>
			    <tr>
			    	<th data-field="sTitle" data-align="center" data-sortable="false" >计划标题</th>
			    	<th data-field="scontent" data-align="center" data-sortable="false" >计划内容</th>
			    	<th data-field="sdate" data-align="center" data-formatter="dateFormatter" data-sortable="false" >创建时间</th>
			    	<th data-field="sFlag" data-align="center" data-formatter="stateFormatter" data-sortable="false" >是否完成</th>
			    	<th data-field="sFinishdate" data-align="center" data-formatter="dateFormatter" data-sortable="false" >完成时间</th>
			    	<th data-align="center" data-formatter="actionFormatteradd" data-events="actionadd" data-sortable="false">操作</th>
			    	<th data-field="sid" data-align="center" data-formatter="actionFormatteredit" data-events="actionedit" data-sortable="false">操作</th>
			    	<th data-field="sid" data-align="center" data-formatter="actionFormatter" data-events="actionEvents" data-sortable="false">操作</th>
			    </tr>
			    </thead>
			</table>
		</div>
	</div>
</div>
<jsp:include page="/static/proscenium/commons/bottom.jsp"></jsp:include>

<%-- <jsp:include page="/static/proscenium/commons/scroll.jsp"></jsp:include> --%>
<!--	***********************************************************  -->
<script src="${path }/static/proscenium/plugin/sweetalert2/sweetalert2.min.js"></script>
<script src="${path }/static/proscenium/js/jquery.min.js"></script>
<script src="${path }/static/proscenium/js/bootstrap.min.js"></script>
<script src="${path }/static/proscenium/plugin/bootstrap-tables/bootstrap-table.min.js"></script>
<script src="${path }/static/proscenium/plugin/bootstrap-tables/bootstrap-table-zh-CN.min.js"></script>
<script src="${path }/static/proscenium/plugin/bootstrap-validator/bootstrapValidator.min.js"></script>
<script src="${path }/static/proscenium/plugin/goup/jquery.goup.min.js"></script>
<script src="${path }/static/proscenium/js/app.js"></script>
<script type="text/javascript">
function actionFormatteradd(value, row, index) {
    return [
        '<a class="open ml10" href="javascript:void(0)" title="添加">',
        '<i class="glyphicon glyphicon-save"></i>',
        '</a>'
    ].join('');
}
function actionFormatteredit(value, row, index) {
    return [
        '<a class="open ml10" href="javascript:void(0)" title="修改">',
        '<i class="glyphicon glyphicon-edit"></i>',
        '</a>'
    ].join('');
}
function actionFormatter(value, row, index) {
    return [
        '<a class="open ml10" href="javascript:void(0)" title="删除">',
        '<i class="glyphicon glyphicon-remove"></i>',
        '</a>'
    ].join('');
}
function dateFormatter(value) {
	if(value != null){
		var date = value.split("-")[0]+"/"+value.split("-")[1]+"/"+(value.split("-")[2]).split(" ")[0];
	    return date
	}
}
function stateFormatter(value) {
	if(value=="0"){
		value="未完成";
	}else{
		value="完成";
	}
	return value;
}

window.actionadd = {
'click .open': function (e, value, row, index) {
	swal({
    	  title: '',
    	  html:
    	    '标题<input id="sTitle" name="sTitle" type="text" class="swal2-input">' +
    	    '内容 <textarea id="scontent" name ="scontent" class="form-control" rows="3"></textarea>',
    	  preConfirm: function() {
    		  var sTitle = $('#sTitle').val();
	          var scontent = $('#scontent').val();
	          var id = ${user.id};
    	      return new Promise(function(resolve) {
   	   			$.post("${path }/schedule/add1",{"sTitle":sTitle,"scontent":scontent,"id":id},function(data) {
   	   				data = $.parseJSON(data);
   	   				if(data.success == true){
						sweetAlert(
							data.msg,
	   	   				  	'',
	   	   				  	'success'
	     	   			)
	     	   			$('#scheduleTable').bootstrapTable('refresh');
					}else{
						sweetAlert(
							data.msg,
	   	   				  	'',
	   	   				  	'error'
	     	   			)
					}
				});
    	    });
    	  }
    	})
    }
}

window.actionEvents = {
	'click .open': function (e, value, row, index) {
	swal({
		  title: '提示',
		  text: '你确定要删除吗?',
		  type: 'warning',
		  showCancelButton: true,
		  confirmButtonText: '确认',
		  cancelButtonText: '取消',
		}).then(function(isConfirm) {
		  if (isConfirm === true) {
		    $.post('${path }/schedule/delete', {
                id : value
            }, function(result) {
                if (result.success) {
                	swal(
              		      '删除成功!',
              		      result.msg,
              		      'success'
              		    );
                    $('#scheduleTable').bootstrapTable('refresh');
                }
            }, 'JSON');
		  } else if (isConfirm === false) {
		    /* swal(
		      'Cancelled',
		      'Your imaginary file is safe :)',
		      'error'
		    ); */
		  } else {
		    // Esc, close button or outside click
		    // isConfirm is undefined
		  }
		});
    }
}
</script>
</body>
</html>