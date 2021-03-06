<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="tools" prefix="t"%>

<link type="text/css" rel="stylesheet" href="css/login.css?t=${t:config('token.css')}" />

<div class="login">
	<div class="logo"></div>
	<div class="main">
		<form method="post" id="loginForm">
			<table cellspace="0" cellpadding="0">
				<col width="93px" /><col />
				<tr>
					<th>用户名:</th>
					<td><input type="text" name="userName" id="userName" class="important" /></td>
				</tr>
				<tr>
					<th>密　码:</th>
					<td><input type="password" name="userPwd" id="userPwd" class="important" /></td>
				</tr>
			</table>
	
			<div class="btn">
				<a href="javascript:" class="btn" onclick="login();return false;"></a>
			</div>
		</form>
	</div>
	<div class="bottom"></div>
</div>

<script type="text/javascript">
	$(function() {
		validateMark(".important","star-inner-pre");
		
		$("#loginForm").validate({
			// 提交时不自动校验
			onsubmit: false,
			// 设置校检规则
			rules:{
				userName: "required",
				userPwd: "required"
			},
			// 设置校检信息
			messages:{
				userName:"用户名不能为空！",
				userPwd:"密码不能为空！"
			},
			// 设置校验信息显示形式
			showErrors : function(errorMap, errorList) {
				// 执行默认操作
				this.defaultShowErrors();
	
				// 自定义校验信息显示形式
				_showErrors(errorMap, errorList,{
					type: "label",
					form: this.currentForm,
					settings: this.settings
				});
			},
			// 设置有出错信息时的操作
			invalidHandler : function(e, validator) {
				// 自定义出错反馈
				_invalidHandler(e, validator);
			}
		});
	});
	
	function login() {
		// 校验用户名，密码是否为空	
		if (!($("#loginForm").validate().form())) {
			return false;
		} 
		ajaxCommon({
			// 调用controller的验证登陆方法
			url : "passport/login_verify",
			data : {
				userName : $("#userName").val(),
				// 对用户密码进行加密
				userPwd : hex_md5($("#userPwd").val())
			}
		}, function(msg) {
			if (msg != "") {
				// 登陆验证失败，返回失败信息
				alert(msg);
			} else {
				// 登陆成功，跳转到个人中心页面
				window.location = "${base}passport/center";
			} 
		});
	}
</script>
