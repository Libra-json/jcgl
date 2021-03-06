<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#scheduleAddForm').form({
            url : '${path }/schedule/add',
            onSubmit : function() {
                progressLoad();
                var isValid = $(this).form('enableValidation').form('validate');
                if (!isValid) {
                    progressClose();
                }
                return isValid;
            },
            success : function(result) {
                progressClose();
                result = $.parseJSON(result);
                if (result.success) {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
        
    });
    
    var userDataGrid;
    function selectUser() {
  	  userDataGrid = $('#userDataGrid').datagrid({
            url : '${path }/user/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : true,
            sortName : 'createTime',
            sortOrder : 'asc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [{
                width : '80',
                title : 'ID',
                field : 'id',
                checkbox : true,
                sortable : true
            },{
                width : '80',
                title : '姓名',
                field : 'name',
                sortable : true
            },{
                width : '80',
                title : '所属部门',
                field : 'organizationName'
            },{
                width : '40',
                title : '性别',
                field : 'sex',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '男';
                    case 1:
                        return '女';
                    }
                }
            },{
                width : '40',
                title : '年龄',
                field : 'age',
                sortable : true
            },{
                width : '120',
                title : '电话',
                field : 'phone',
                sortable : true
            }] ],
         });
  	  $('#win').window('open');
    } 
    
    $("#addbtn").click(function() {
  	  var row = $('#userDataGrid').datagrid('getSelected');
  	  $("#userId").val(row.id);
  	  $("#name").val(row.name);
  	  $('#win').window('close');
  	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="scheduleAddForm" method="post">
            <table class="grid">
                <tr>
                    <td>姓名</td>
                    <td>
                    	<c:if test="${userid eq 1}">
                    		<input id="userId" name="userId" hidden="true">
	                    	<input id="name" name="atName" type="text" placeholder="请选择计划执行人" class="easyui-validatebox" style="width:100px;" data-options="required:true,novalidate:true" readonly="readonly" value="">
	                    	<input type="button" onclick="selectUser();" value="点击选择">
                    	</c:if>
                    	<c:if test="${userid ne 1}">
                    		<input id="userId" name="userId" value="${userid}" hidden="true">
	                    	<input id="name" name="atName" type="text" class="easyui-validatebox" style="width:100px;" data-options="required:true,novalidate:true" readonly="readonly" value="${username}">
                    	</c:if>
                    </td>
                </tr>
                <tr>
                	<td>计划标题</td>
                    <td>
                    	<input name="sTitle" type="text" placeholder="请输入标题" class="easyui-validatebox" data-options="required:true,novalidate:true" value="">
                    </td>
                </tr>
                <tr>
                	<td>计划内容</td>
                    <td>
                    	<input name="sContent" placeholder="请输入计划内容" class="easyui-textbox" data-options="multiline:true,required:true,novalidate:true" value="" style="width:180px;height:50px">
                    	<input id="sFlag" name="sFlag" value="0" hidden="true">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<div id="win" class="easyui-window" title="用户表" closed="true"  style="width:440px;height:300px;">
  	<div style="width:430px;height:220px;">
  		<table id="userDataGrid" data-options="fit:true,border:false"></table>
  	</div>
	<center><a href="javascript:;" id="addbtn" style="margin-top:10px;" class="easyui-linkbutton" data-options="toggle:true,group:'g1',iconCls:'icon-ok'" >确定</a></center>
</div>