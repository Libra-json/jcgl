<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var scheduleDataGrid;

    $(function() {
    	scheduleDataGrid = $('#scheduleDataGrid').datagrid({
            url : '${path }/schedule/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : false,
            idField : 'sid',
            sortName : 's_date',
	        sortOrder : 'desc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '100',
                title : '姓名',
                field : 'listUser',
                sortable : true,
                formatter : function(value, row, index) {
                    var roles = [];
                    for(var i = 0; i< value.length; i++) {
                        roles.push(value[i].name);  
                    }
                    return(roles.join('\n'));
                }
            }, {
                width : '120',
                title : '计划标题',
                field : 'sTitle',
                sortable : true
            },{
                width : '120',
                title : '计划内容',
                field : 'scontent',
                sortable : true
            },{
                width : '120',
                title : '创建时间',
                field : 'sdate',
                sortable : true,
                formatter: formatDatebox
            },{
                width : '120',
                title : '完成时间',
                field : 'sFinishdate',
                sortable : true,
                formatter: formatDatebox
            },{
                width : '80',
                title : '报考类型',
                field : 'sFlag',
                formatter : function(value, row, index) {
               	   if(value==0) {
               			return "未完成";
                   }else {
                   		return "已完成";
                   }
                }
            },{
                field : 'action',
                title : '操作',
                width : 130,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/schedule/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editScheduleFun(\'{0}\');" >编辑</a>', row.sid);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/schedule/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="user-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteScheduleFun(\'{0}\');" >删除</a>', row.sid);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.user-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.user-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#scheduleToolbar'
        });
    });
    
    function addScheduleFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 270,
            height : 200,
            href : '${path }/schedule/addpage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = scheduleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#scheduleAddForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteScheduleFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = scheduleDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
        	scheduleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前数据？', function(b) {
            if (b) {
	            progressLoad();
	            $.post('${path }/schedule/delete', {
	                id : id
	            }, function(result) {
	                if (result.success) {
	                    parent.$.messager.alert('提示', result.msg, 'info');
	                    scheduleDataGrid.datagrid('reload');
	                }
	                progressClose();
	            }, 'JSON');
            }
        });
    }
    
    function editScheduleFun(id) {
        if (id == undefined) {
            var rows = scheduleDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	scheduleDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 270,
            height : 250,
            href : '${path }/schedule/editpage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = scheduleDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#scheduleEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    Date.prototype.format = function (format) {    
        var o = {    
            "M+": this.getMonth() + 1,   
            "d+": this.getDate(),    
            "h+": this.getHours(),   
            "m+": this.getMinutes(),    
            "s+": this.getSeconds(),  
            "q+": Math.floor((this.getMonth() + 3) / 3),  
            "S": this.getMilliseconds()    
        }    
        if (/(y+)/.test(format))    
            format = format.replace(RegExp.$1, (this.getFullYear() + "")    
                .substr(4 - RegExp.$1.length));    
        for (var k in o)    
            if (new RegExp("(" + k + ")").test(format))    
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));    
        return format;    
    }    
    function formatDatebox(value) {    
        if (value == null || value == '') {    
            return '';    
        }    
        var dt;    
        if (value instanceof Date) {    
            dt = value;    
        } else {    
            dt = new Date(value);    
        }    
        return dt.format("yyyy-MM-dd");  
    }  
    
    function searchScheduleFun() {
    	scheduleDataGrid.datagrid('load', $.serializeObject($('#searchScheduleForm')));
    }
    function cleanScheduleFun() {
        $('#searchScheduleForm input').val('');
        scheduleDataGrid.datagrid('load', {});
    }

    function batch_complete() {
    	var ids = [];
    	var k=0;
    	var rows = $('#scheduleDataGrid').datagrid('getSelections');
    	for(var i=0; i<rows.length; i++){
    		ids.push(rows[i].sid);
			if(rows[i].sFlag==1){
				k++;
			}
    	}
    	if(ids!='' && ids!=null) {
        	if(k==0) {
        		parent.$.messager.confirm('询问', '您确定完成选中的工作提醒吗？', function(b) {
    	            if (b) {
    		            progressLoad();
    		            $.post('${path }/schedule/batch_complete', {
    		            	ids : ids.join(',')
    		            }, function(result) {
    		                if (result.success) {
    		                    parent.$.messager.alert('提示', result.msg, 'info');
    		                    scheduleDataGrid.datagrid('reload');
    		                }
    		                progressClose();
    		            }, 'JSON');
    	            }
    	        });
            }else {
            	parent.$.messager.show({
                    title : '提示',
                    msg : '请选择未完成工作提醒！'
                });
            }
        }else {
        	parent.$.messager.show({
                title : '提示',
                msg : '请选择未完成工作提醒！'
            });
        }
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height: 30px; overflow: hidden;background-color: #fff">
        <form id="searchScheduleForm">
            <table>
                <tr>
                    <th>创建时间:</th>
                    <td>
                        <input name="begintime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input  name="endtime" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchScheduleFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanScheduleFun();">清空</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'报名类型'" >
        <table id="scheduleDataGrid" data-options="fit:true,border:false"></table>
    </div>
</div>
<div id="scheduleToolbar" style="display: none;">
    <shiro:hasPermission name="/schedule/add">
        <a onclick="addScheduleFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/schedule/add">
        <a onclick="batch_complete();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-social-foursquare icon-green'">批量完成</a>
    </shiro:hasPermission>
</div>