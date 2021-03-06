<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#ArtexamEditForm').form({
            url : '${path }/Artexam/edit',
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
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    parent.$.modalDialog.handler.dialog('close');
                } else {
                    parent.$.messager.alert('提示', result.msg, 'warning');
                }
            }
        });
    });
    
    
  var artexamDataGrid;
  function selectartexameUser() {
	  artexamDataGrid = $('#artexamDataGrid').datagrid({
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
	  var row = $('#artexamDataGrid').datagrid('getSelected');
	  $("#userId").val(row.id);
	  $("#name").val(row.name);
	  $('#win').window('close');
	});
  
  $.extend($.fn.validatebox.defaults.rules, {
      phoneNum: { //验证手机号   
          validator: function(value, param){ 
           return /^1[3-8]+\d{9}$/.test(value);
          },    
          message: '请输入正确的手机号码。'   
      },
      
      telNum:{ //既验证手机号，又验证座机号
        validator: function(value, param){ 
            return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^((\d3)|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
           },    
           message: '请输入正确的电话号码。' 
   	 }});
  
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="ArtexamEditForm" method="post">
            <table class="grid">
                <tr>
                    <td>学生姓名</td>
                    <td><input name="sName" type="text" placeholder="请输入学生姓名" class="easyui-validatebox" data-options="required:true,novalidate:true" value="${student.SName}"></td>
                	<td>老师姓名</td>
                    <td>
	                    <input id="userId" name="userId" hidden="true" value="${user.id}">
	                    <input id="name" name="name" type="text" placeholder="请选择介绍老师" style="width:100px;" class="easyui-validatebox" data-options="required:true,novalidate:true" readonly="readonly" value="${user.name}">
                    	<input type="button" onclick="selectartexameUser();" value="点击选择">
                    </td>
                </tr>
                <tr>
                	<td>手机号码</td>
                    <td><input name="sPhone" type="text" placeholder="请输入手机号码" class="easyui-validatebox"  data-options="required:true,novalidate:true,prompt:'请输入正确的手机号码。',validType:'phoneNum'" value="${student.SPhone}"></td>
                	<td>报名日期</td>
                    <td><input name="sDate" type="text" placeholder="请选报考日期" class="easyui-datetimebox" data-options="required:true,novalidate:true" value="${student.SDate}"></td>
                </tr>
                <tr>
                	<td>学习内容</td>
                    <td><input name="sContent" type="text" placeholder="请选择学习内容" class="easyui-validatebox" data-options="required:true,novalidate:true" value="${student.SContent}"></td>
                	<td>报名类型</td>
                	<td><select id="stype" name="stype" style="width:100px;height:22px;">
                		<option value="4" <c:if test="${student.stype == 4}">selected</c:if>>艺考</option>
                		<option value="3" <c:if test="${student.stype == 3}">selected</c:if>>会计</option>
                		<option value="5" <c:if test="${student.stype == 5}">selected</c:if>>职业资格</option>
                	</select></td>
                </tr>
                <tr>
                	<td></td>
                	<td><input type="text" name="sId" hidden="true" value="${student.SId}" /></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<div id="win" class="easyui-window" title="用户表" closed="true"  style="width:440px;height:300px;">
  	<div style="width:430px;height:220px;">
  		<table id="artexamDataGrid" data-options="fit:true,border:false"></table>
  	</div>
	<center><a href="javascript:;" id="addbtn" style="margin-top:10px;" class="easyui-linkbutton" data-options="toggle:true,group:'g1',iconCls:'icon-ok'" >确定</a></center>
</div>