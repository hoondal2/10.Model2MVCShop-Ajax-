<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.service.domain.*"%>

<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
<%@ page import="com.model2.mvc.service.domain.*"%>
<%
	session = request.getSession();
	User user = (User)session.getAttribute("user");
	
	Product vo = (Product)request.getAttribute("vo"); %>
/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
	
	<c:set var="user" value="${user}" scope="session"/>
	

<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
<% String menu = request.getParameter("menu");
	System.out.println(menu);
%>
/////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>

<c:set var="menu" value="${param.menu}"/>
<%System.out.println(request.getParameter("menu")); %>

<html>
<head>
	<title>��ǰ����ȸ / ��ǰ����</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
			
			//==> �߰��Ⱥκ� : "����" "Ȯ��"  Event ���� �� ó��
			 $(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
				 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
					//Debug..
					//alert(  $( "td.ct_btn01:contains('Ȯ��')" ).html() );
					history.go(-1);
				});
				 
				 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
						//Debug..
						//alert(  $( "td.ct_btn01:contains('����')" ).html() );
						self.location = "/purchase/addPurchaseView?prodNo=${vo.prodNo}"
				});
				 
				 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
						//Debug..
						//alert(  $( "td.ct_btn01:contains('����')" ).html() );
						self.location = "/product/updateProduct?prodNo=${vo.prodNo}"
				});
			});
		 </script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<table width="100%" height="37" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
				width="15" height="37"></td>
			<td background="/images/ct_ttl_img02.gif" width="100%"
				style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
				width="12" height="37"></td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 13px;">
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">��ǰ��ȣ <img
				src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">${vo.prodNo}</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>

		<tr>
			<td width="104" class="ct_write">��ǰ�� <img
				src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.prodName}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">��ǰ�̹���</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.fileName}</td>

		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">��ǰ������</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.prodDetail}</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">��������</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="26">${vo.manuDate}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>

		<tr>
			<td width="104" class="ct_write">����</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.price}</td>

		</tr>

		</td>
		</tr>
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>

		<tr>
			<td width="104" class="ct_write">�������</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${vo.regDate}</td>

		</tr>

		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
	</table>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				
					
					<!-- /////////////////// �α��� / �̷α��� ���� ///////////////////-->
					<c:if test = "${!empty user}">
					<!--///////////// menu==manage�϶� ������ ������ư ���� //////////////-->
							<%--if(menu.equals("manage")){ --%>
							<c:if test = "${param.menu eq 'manage'}">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<!-- ////////////////// jQuery Event ó���� ����� ////////////////////////////////////////////////// 
								<a href="/product/updateProduct?prodNo=${vo.prodNo}">����</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
							����
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</td>
							<td width="30"></td>
							
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif"
								width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"
								style="padding-top: 3px;">
							<!-- ////////////////// jQuery Event ó���� ����� ////////////////////////////////////////////////// 
								<a href="javascript:history.go(-1);">����</a> 
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
							����
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</tr>
						</table>
							</c:if>
							<!--///////////// menu==search �϶� ���ſ� ������ư ���� ////////////////-->
							<c:if test = "${param.menu eq 'search'}">
							<table border="0" cellspacing="0" cellpadding="0">
							<tr>
									<td width="17" height="23">
										<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
									</td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
										<!-- ////////////////// jQuery Event ó���� ����� ////////////////////////////////////////////////// 
										<a href="/purchase/addPurchaseView?prod_no=${vo.prodNo}">����</a>
										////////////////////////////////////////////////////////////////////////////////////////////////// -->
										����
									</td>
									<td width="14" height="23">
										<img src="/images/ct_btnbg03.gif" width="14" height="23">
									</td>
									<td width="30"></td>
									<td width="17" height="23">
										<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
									</td>
									<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<!-- ////////////////// jQuery Event ó���� ����� ////////////////////////////////////////////////// 
										<a href="javascript:history.go(-1)">����</a>
									////////////////////////////////////////////////////////////////////////////////////////////////// -->
									����
									</td>
									<td width="14" height="23">
										<img src="/images/ct_btnbg03.gif" width="14" height="23">
									</td>
							</tr>
							</table>
							</c:if>
						</c:if>
			<!-- //////////////////////// �̷α��ν� ������ư�� ���� /////////////////////////// -->
						<c:if test = "${empty user}">
							<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								<!-- ////////////////// jQuery Event ó���� ����� ////////////////////////////////////////////////// 
								<a href="javascript:history.go(-1)">����</a>
								////////////////////////////////////////////////////////////////////////////////////////////////// -->
								����
								</td>
								<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
							</tr>
							</table>
						</c:if>
</body>
</html>