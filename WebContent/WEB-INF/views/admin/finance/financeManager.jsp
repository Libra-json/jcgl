<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp" %>
<script type="text/javascript">
    var financeDataGrid;
    $(function() {
		
        financeDataGrid = $('#financeDataGrid').datagrid({
            url : '${path }/finance/dataGrid',
            fit : true,
            striped : true,
            rownumbers : true,
            pagination : true,
            singleSelect : false,
            idField : 'fid',
            sortName : 'f_date',
	        sortOrder : 'desc',
            pageSize : 20,
            pageList : [ 10, 20, 30, 40, 50, 100, 200, 300, 400, 500 ],
            columns : [ [ {
                width : '80',
                field : 'fid',
                checkbox:true
            },{
                width : '60',
                title : '姓名',
                field : 'studentsname',
                formatter : function(value, row, index) {
                	if (row.student){
                        if(row.student.sname!= '')
                            return row.student.sname;
                        else{
                            return '';
                        }
                    } else {
                        return '';
                    }
                }
            }, {
                width : '75',
                title : '学号',
                field : 'stuNo',
                sortable : true
            },{
                width : '80',
                title : '学校',
                field : 'studentacademy',
                formatter : function(value, row, index) {
                	if (row.student){
                        if(row.student.academyId!= '')
                            return row.student.academyId;
                        else{
                            return '';
                        }
                    } else {
                        return '';
                    }
                }
            },{
            	width : '70',
                title : '专业',
                field : 'studentscontent',
                formatter : function(value, row, index) {
                	if (row.student){
                        if(row.student.scontent!= '')
                            return row.student.scontent;
                        else{
                            return '';
                        }
                    } else {
                        return '';
                    }
                }
            },{
            	width : '70',
                title : '层次',
                field : 'studentsgradations',
                formatter : function(value, row, index) {
                	if (row.student){
                        if(row.student.sgradations != '')
                            return row.student.sgradations;
                        else{
                            return '';
                        }
                    } else {
                        return '';
                    }
                }
            },{
                width : '70',
                title : '班主任',
                field : 'teaClass',
                sortable : true
            },{
                width : '80',
                title : '合作人',
                field : 'user',
                formatter : function(value, row, index) {
                    return value.name;
                }
            },{
                width : '60',
                title : '需缴金额',
                field : 'needMoney',
                sortable : true
            },{
                width : '60',
                title : '实缴金额',
                field : 'practicalMoney',
                sortable : true
            },{
                width : '60',
                title : '学期',
                field : 'fobligate',
                sortable : true
            },{
                width : '130',
                title : '缴费时间',
                field : 'fdate',
                sortable : true
            },{
                width : '80',
                title : '缴费方式',
                field : 'fway',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '';
                    case 1:
                        return '支付宝';
                    case 2:
                        return '微信';
                    case 3:
                        return '银行转账';
                    case 4:
                        return '现金';
                    }
                }
            },{
                width : '60',
                title : '累计金额',
                field : 'faccumulative',
                sortable : true
            },{
                width : '80',
                title : '缴费状态',
                field : 'fstate',
                sortable : true,
                formatter : function(value, row, index) {
                    switch (value) {
                    case 0:
                        return '';
                    case 1:
                        return '未缴费';
                    case 2:
                        return '已缴费';
                    case 3:
                        return '已兑账';
                    }
                }
            },{
                width : '80',
                title : '报考类型',
                field : 'studentstype',
                formatter : function(value, row, index) {
                	if (row.student){
                        if(row.student.stype!= ''){
                            var type = row.student.stype;
                        	if(type==1) {
                        		return "成人高考";
                            }else if(type==2){
                            	return "国家开放大学";
                            }else {
                            	return "远程教育";
                            }
                        }else{
                            return '';
                        }
                    } else {
                        return '';
                    }
                }
            },{
                field : 'action',
                title : '操作',
                width : 200,
                formatter : function(value, row, index) {
                    var str = '';
                        <shiro:hasPermission name="/finance/edit">
                            str += $.formatString('<a href="javascript:void(0)" class="finance-easyui-linkbutton-edit" data-options="plain:true,iconCls:\'fi-pencil icon-blue\'" onclick="editFinanceFun(\'{0}\');" >编辑</a>', row.fid);
                        </shiro:hasPermission>
                        <shiro:hasPermission name="/finance/delete">
	                        str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
	                        str += $.formatString('<a href="javascript:void(0)" class="finance-easyui-linkbutton-print" data-options="plain:true,iconCls:\'fi-print icon-blue\'" onclick="preview(1);" >打印</a>', row.fid);
                    	</shiro:hasPermission>
                        <shiro:hasPermission name="/finance/delete">
                            str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
                            str += $.formatString('<a href="javascript:void(0)" class="finance-easyui-linkbutton-del" data-options="plain:true,iconCls:\'fi-x icon-red\'" onclick="deleteFinanceFun(\'{0}\');" >删除</a>', row.fid);
                        </shiro:hasPermission>
                    return str;
                }
            }] ],
            onLoadSuccess:function(data){
                $('.finance-easyui-linkbutton-edit').linkbutton({text:'编辑'});
                $('.finance-easyui-linkbutton-print').linkbutton({text:'打印'});
                $('.finance-easyui-linkbutton-del').linkbutton({text:'删除'});
            },
            toolbar : '#financeToolbar'
        });
    });
    

	function preview(oper) {
	if (oper < 10){
		bdhtml=window.document.body.innerHTML;//获取当前页的html代码 
		sprnstr="<!--startprint"+oper+"-->";//设置打印开始区域 
		eprnstr="<!--endprint"+oper+"-->";//设置打印结束区域 
		prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html 
		
		prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html 
		window.document.body.innerHTML=prnhtml;
		window.print();
		window.document.body.innerHTML=bdhtml;
	}else{
		window.print();
		}
	}
    
    function addFinanceFun() {
        parent.$.modalDialog({
            title : '添加',
            width : 535,
            height : 255,
            href : '${path }/finance/addPage',
            buttons : [ {
                text : '添加',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = financeDataGrid; //因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#financeAddForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function deleteFinanceFun(id) {
        if (id == undefined) {//点击右键菜单才会触发这个
            var rows = financeDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {//点击操作里面的删除图标会触发这个
            financeDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
            if (b) {
                    progressLoad();
                    $.post('${path }/finance/delete', {
                        id : id
                    }, function(result) {
                        if (result.success) {
                            parent.$.messager.alert('提示', result.msg, 'info');
                            financeDataGrid.datagrid('reload');
                        }
                        progressClose();
                    }, 'JSON');
            }
        });
    }
    
    function editFinanceFun(id) {
    	if (id == undefined) {
            var rows = financeDataGrid.datagrid('getSelections');
            id = rows[0].id;
        } else {
        	financeDataGrid.datagrid('unselectAll').datagrid('uncheckAll');
        }
        parent.$.modalDialog({
            title : '编辑',
            width : 500,
            height : 300,
            href : '${path }/finance/editPage?id=' + id,
            buttons : [ {
                text : '确定',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = financeDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#financeEditForm');
                    f.submit();
                }
            } ]
        });
    }
    
    function searchFinanceFun() {
    	financeDataGrid.datagrid('load', $.serializeObject($('#searchFinanceForm')));
    }
    function cleanFinanceFun() {
    	$('#fObligate').find("option").eq(0).prop("selected",true);
    	$('#fState').find("option").eq(0).prop("selected",true);
    	$('#stype').find("option").eq(0).prop("selected",true);
    	$('#fWay').find("option").eq(0).prop("selected",true);
    	$('#studentstype').find("option").eq(0).prop("selected",true);
        $('#searchFinanceForm input').val('');
        financeDataGrid.datagrid('load', {});
    }

   	//导出excel
    function toExcel(){
    	var teaClass = $("#teaClass").val();
    	var stuNo = $("#stuNo").val();
    	var fState = $("#fState").val();
    	var createdateStart = $("#createdateStart").val();
    	var createdateEnd = $("#createdateEnd").val();
    	var url = '${path }/finance/download_finance?teaClass='+teaClass+'&stuNo='+stuNo+'&fState='+fState+'&createdateStart='+createdateStart+'&createdateEnd='+createdateEnd;
    	window.open(url);
    }

    //上传excel
    function fromExcel() {
    	parent.$.modalDialog({
            title : '上传',
            width : 300,
            height : 150,
            href : '${path }/finance/goUploadExcel',
            buttons : [ {
                text : '导入',
                handler : function() {
                    parent.$.modalDialog.openner_dataGrid = financeDataGrid; //因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                    var f = parent.$.modalDialog.handler.find('#uploadForm');
                    f.submit();
                }
            },{
        		text : '取消',
        		handler : function() {
        		parent.$.modalDialog.handler.dialog('destroy');
        		parent.$.modalDialog.handler = undefined;
        		}}]
        });
    }

    function batch_pay() {
    	var ids = [];
    	var rows = $('#financeDataGrid').datagrid('getSelections');
    	for(var i=0; i<rows.length; i++){
    		ids.push(rows[i].fid);
    	}
    	if(ids!='' && ids!=null) {
        	parent.$.modalDialog({
                title : '批量缴费',
                width : 300,
                height : 200,
                href : '${path }/finance/batchPay_Page?ids=' + ids.join(','),
                buttons : [ {
                    text : '确定缴费',
                    handler : function() {
                        parent.$.modalDialog.openner_dataGrid = financeDataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
                        var f = parent.$.modalDialog.handler.find('#financebatch');
                        f.submit();
                    }
                } ]
            });
        }else {
        	parent.$.messager.show({
                title : '提示',
                msg : '请选择需缴费学生！'
            });
        }
    }
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'north',border:false" style="height:60px; overflow: hidden;background-color: #fff">
        <form id="searchFinanceForm">
            <table>
                <tr>
                    <th>合作人:</th>
                    <td><input id="teaClass" name="teaClass" style="width:80px;" placeholder="请输入合作人"/></td>
                    <th>学号:</th>
                    <td><input id="stuNo" name="stuNo" style="width:90px;" placeholder="请输入学号"/></td>
                    <th>学生姓名:</th>
                    <td>
                    	<input id="sName" name="sName" style="width:100px;" placeholder="请输入学生姓名">
                    </td>
                    <th>学期:</th>
                    <td>
                    	<select id="fObligate" name="fObligate">
                    		<option value="请选择学期">请选择学期</option>
                    		<option value="第一学期">第一学期</option>
                    		<option value="第二学期">第二学期</option>
                    		<option value="第三学期">第三学期</option>
                    	</select>
                    </td>
                    <th>缴费状态:</th>
                    <td>
                    	<select id="fState" name="fState">
							<option value="0">缴费状态</option>
							<option value="1">未缴费</option>
							<option value="2">已缴费</option>
							<option value="3">已兑帐</option>
						</select>
                    </td>
                    <th>缴费时间:</th>
                    <td>
                    	<!-- <input name="createdateStart" type="text" class="easyui-datetimebox" /> -->
                    	<input id="createdateStart" name="createdateStart" style="width:120px;" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至
                        <input id="createdateEnd" name="createdateEnd" style="width:120px;" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-magnifying-glass',plain:true" onclick="searchFinanceFun();">查询</a>
                        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'fi-x-circle',plain:true" onclick="cleanFinanceFun();">清空</a>
                    </td>
                </tr>
                <tr>
                	<th>缴费方式:</th>
                	<td>
                		<select id="fWay" name="fWay">
                			<option value="0">缴费方式</option>
                			<option value="1">支付宝</option>
                			<option value="2">微信</option>
                			<option value="3">银行卡转账</option>
                			<option value="4">现金</option>
                		</select>
                	</td>
                	<th>报考类型:</th>
                	<td>
                		<select id=stype name="stype">
                			<option value="0">报考类型</option>
                			<option value="1">成人高考</option>
                			<option value="6">远程教育</option>
                			<option value="2">国家开放大学</option>
                		</select>
                	</td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'center',border:true,title:'缴费人员列表'" >
        <!--startprint1-->
        <table id="financeDataGrid" data-options="fit:true,border:false"></table>
   		<!--endprint1-->
    </div>
</div>
<div id="financeToolbar" style="display: none;">
    <shiro:hasPermission name="/finance/add">
        <a onclick="addFinanceFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-plus icon-green'">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/finance/upload_finance">
        <a onclick="fromExcel();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-upload icon-green'" >上传缴费数据</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/finance/download_finance">
        <a onclick="toExcel();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-download icon-green'" >导出当前数据</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="/finance/batchPay">
        <a onclick="batch_pay();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'fi-dollar-bill icon-green'" >批量缴费</a>
    </shiro:hasPermission>
</div>