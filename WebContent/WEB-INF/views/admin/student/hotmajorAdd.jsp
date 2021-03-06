<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#hotmajorAddForm').form({
            url : '${path }/hotmajor/add',
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
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;">
        <form id="hotmajorAddForm" method="post" enctype="multipart/form-data">
            <table class="grid">
                <tr>
                    <td>标题</td>
                    <td><input name="hmTitle" type="text" placeholder="请输入标题" class="easyui-validatebox" data-options="required:true,novalidate:true" value=""></td>
                </tr>
                <tr>
                	<td>图片</td>
                    <td><input name="price" type="file" ></td>
                </tr>
                <tr>
                	<td>内容</td>
                	<td colspan="4">
						<textarea name="hmContent" cols="" rows="4" style="width:80%;" class="textarea" placeholder="这里输入内容" data-options="required:true,novalidate:true"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>