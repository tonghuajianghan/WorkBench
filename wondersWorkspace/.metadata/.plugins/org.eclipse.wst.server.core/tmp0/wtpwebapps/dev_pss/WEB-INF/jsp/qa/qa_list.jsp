<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<form id="qaForm" action="qa/qa_list" method="post">
		<dl class="banner">
			<dd class="back">
				<a href="javascript:" onclick="window.history.go(-1);return false;"></a>
			</dd>
			<dd class="search">
				<a href="javascript:" onclick="$('#qaForm').submit();return false;"></a>
			</dd>
			<dd class="cond">
				<select name="prodId">
					<option value="">所有产品</option>
					<c:forEach var="dic" items="${dicProd}">
						<option value="${dic.key}"
							${condition.prodId eq dic.key ? 'selected' : ''}>${dic.value}</option>
					</c:forEach>
				</select>
			</dd>
			<dt class="cond">问题所属产品</dt>

			<dd class="cond">
				<input type="text" name="tagDesc" value="${condition.tagDesc}" />
			</dd>
			<dt class="cond">问题标签</dt>

			<dd class="cond">
				<input type="text" name="qaDesc" value="${condition.qaDesc}" />
			</dd>
			<dt class="cond">问题描述</dt>
		</dl>
		<input type="hidden" id="pageNo" name="pageNo"
			value="${condition.pageNo}" />
	</form>

	<table cellspace="0" cellpadding="0" class="list">
		<col width="41px" />
		<col width="80px" />
		<col />
		<tr>
			<th>&nbsp;</th>
			<th>问题管理</th>
			<th>
				<a href="javascript:" onclick="editQa();return false;" class="op add" title="新增问题"></a>
				<a href="javascript:" onclick="batchdel();return false;" class="op del" title="批量删除问题"></a> 
			</th>
		</tr>
	</table> 
	
	<table cellspace="0" cellpadding="0" class="list">
		<col width="10%" />
		<col width="30%" />
		<col width="20%" />
		<col width="20%" />
		<col width="20%" />
		<tr>
			<th class="center"><input type="checkbox" class="checkbox"
				id="checkAll" /></th>
			<th class="center">问题</th>
			<th class="center">问题标签</th>
			<th class="center">所属产品</th>
			<th class="center">操作</th>
		</tr>
		
		<c:if test="${empty page.result}">
			<tr>
				<th class="center" colspan="5">未能找到符合条件的结果！</th>
			</tr>
		</c:if>
		<c:if test="${not empty page.result}">
			<c:forEach var="qa" items="${page.result}">
				<tr>
					<td class="center"><input type="checkbox" name="qaId"
						value="${qa.qaId}" class="checkbox" /></td>
					<td class="center"><a onclick="editQa('${qa.qaId}')"
						href="javascript:void(0)">${qa.qaDesc}</a></td>
					<td class="center"><c:forEach var="tags"
							items="${qa.pssQaTagSet}">
	                    ${tags.tagDesc}                
	                    &nbsp;&nbsp;
						</c:forEach></td>
					<td class="center">${dicProd[qa.prodId]}</td>
					<td class="center"><a href="javascript:"
						onclick="delQa('${qa.qaId}');return false;">删除</a></td>
				</tr>
			</c:forEach>
		</c:if>
		<tr>
			<td colspan="5" class="page-container" />
		</tr>
	</table>

<script type="text/javascript">
        $(function(){
            paging.form.init({
                container: ".page-container",
                numb: "#pageNo",
                page: "${page.pageCount}",
                total: "${page.count}",
                form: "#qaForm"
            });
        })

        function editQa(qaId){        	
        	var url = '${base}qa/qa_edit?qaId='+qaId;
        	window.location.href = url;
        }
       // 删除单个问题
        function delQa(qaId){
        	dialogMessage("确定要删除该问题！", function(content) {
				content.dialog("destroy").remove();
				ajaxCommon({
					url: "qa/delete",
					data:{
						qaId: qaId
						}
				}, function(message) {
					if(message == "success") {
						// 返回信息为空，表示删除成功，弹出提示信息
						dialogMessage("问题删除成功！", function(content) {
							// 关闭提示窗口
							content.dialog("destroy").remove();
							// 刷新问题列表
							$('#qaForm').submit();
						});
					} else {
						// 返回信息不为空，则表示保存失败，弹出失败信息
						dialogMessage(message);
					}
				}); 
			},true);        	
        }
        
      //批量删除选中问题
    	function batchdel(){
    		var qaIdStr="";
    		//将选中问题的id放入字符串userIdStr中
    		$("input[name='qaId']:checked").each(function(i){
    			qaIdStr += $(this).val()+";";
    		});
    		
    		//没有选中数据的话给出提示
    		if(qaIdStr==''){
    			dialogMessage("请至少选择一条问题", function(content) {
    				content.dialog("destroy").remove();
    				return false;
    			});
    		} else {
    			dialogMessage("确定要批量删除问题！", function(content) {
    				content.dialog("destroy").remove();
    				ajaxCommon({
    					url:"qa/batchDelete",
    					data: {
    						idStr: qaIdStr
    					}
    				},function(message) {
    					if(message == "success") {
    						// 返回信息为空，表示批量删除成功，弹出提示信息
    						dialogMessage("批量删除问题成功！", function(content) {
    							//关闭提示窗口
    							content.dialog("destroy").remove();
    							//刷新问题列表
    							$('#qaForm').submit();
    						});
    					} else {
    						// 返回信息不为空，则表示批量删除失败，弹出失败信息
    						dialogMessage(message);
    					}
    				});
    			}, true);
    		}
    	}
    	
    	//当前页面问题全选、全不选
    	$(function() {
    		$("#checkAll").click(function() {
    			 $("[name='qaId']").attr("checked", this.checked);
    		});
    	});
        	
    </script>