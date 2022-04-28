<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	session = request.getSession();
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	System.out.println("searchCondition");
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	System.out.println("searchKeyword");
%>

<% String menu = request.getParameter("menu"); // 널 발생 주의
	System.out.println(menu);%>
///////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////// --%>

<c:set var="menu" value="${param.menu}" />
<%
System.out.println(request.getParameter("menu"));
%>


<html>
<head>

<title>상품관리 / 상품목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<!--////////////////// 메뉴에 따라 자바스크립트 실행을 다르게 .../////////////// -->
<c:if test="${param.menu eq 'manage'}">
	<script type="text/javascript">
		function fncGetList(currentPage) {

			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
			//document.detailForm.action='/product/listProduct?menu=manage';
			$("form").attr("method", "POST").attr("action",
					"/product/listProduct?menu=manage").submit();
		}

		$(function() {
			$("td.pp").on(
					"click",
					function() {	
					////////////////////////////추가 , 변경된 부분 ///////////////////////////////////
					////self.location = "/product/getProduct?prodNo="+ $(this).attr('prodNo') + "&menu=manage";
					////////////////////////////////////////////////////////////////////////////////////////////
					var prodNo = $(this).attr('prodNo');
					$.ajax( 
							{
								url : "/product/json/getProduct/"+prodNo+ "?menu=manage" ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h3><br/>"
																+"상품번호 : "+JSONData.prodNo+"<br/>"
																+"상품명 : "+JSONData.prodName+"<br/>"
																+"상품이미지 : "+JSONData.fileName+"<br/>"
																+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
																+"제조일자 : "+JSONData.manuDate+"<br/>"
																+"가격 : "+JSONData.price+"<br/>"
																+"등록일자 : "+JSONData.regDate+"<br/>"
																+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "#"+prodNo+"" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////	
					
					})
		});
		
	</script>
</c:if>

<c:if test="${param.menu eq 'search'}">
	<script type="text/javascript">
		function fncGetList(currentPage) {
			//document.getElementById("currentPage").value = currentPage;
			$("#currentPage").val(currentPage)
			//document.detailForm.action='/product/listProduct?menu=manage';
			$("form").attr("method", "POST").attr("action",
					"/product/listProduct?menu=search").submit();
		}

		$(function() {
			$("td.pp").on(
					"click",
					function() {
////////////////////////////추가 , 변경된 부분 ///////////////////////////////////
						////self.location = "/product/getProduct?prodNo="+ $(this).attr('prodNo') + "&menu=manage";
						////////////////////////////////////////////////////////////////////////////////////////////
						var prodNo = $(this).attr('prodNo');
						$.ajax( 
								{
									url : "/product/json/getProduct/"+prodNo+ "?menu=search" ,
									method : "GET" ,
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status) {

										//Debug...
										//alert(status);
										//Debug...
										//alert("JSONData : \n"+JSONData);
										
										var displayValue = "<h3><br/>"
																	+"상품번호 : "+JSONData.prodNo+"<br/>"
																	+"상품명 : "+JSONData.prodName+"<br/>"
																	+"상품이미지 : "+JSONData.fileName+"<br/>"
																	+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
																	+"제조일자 : "+JSONData.manuDate+"<br/>"
																	+"가격 : "+JSONData.price+"<br/>"
																	+"등록일자 : "+JSONData.regDate+"<br/>"
																	+"</h3>";
										//Debug...									
										//alert(displayValue);
										$("h3").remove();
										$( "#"+prodNo+"" ).html(displayValue);
									}
							});
							////////////////////////////////////////////////////////////////////////////////////////////
					})
		});
	</script>
</c:if>

<script>
		//===========================================//
		//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
		 $(function() {
			 
			//==> 검색 Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
			 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
				fncGetList(1);
			});
			
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> 아래와 같이 정의한 이유는 ??
			//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			
			console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		});	
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<c:if test="${param.menu eq 'search'}">
									<td width="93%" class="ct_ttl01">상품목록조회</td>
								</c:if>
								<c:if test="${param.menu eq 'manage'}">
									<td width="93%" class="ct_ttl01">상품관리</td>
								</c:if>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}" 
								class="ct_input_g"
						style="width: 200px; height: 19px"></td>

					<!-- <td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0">상품번호</option>
				<option value="1">상품명</option>
			</select>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" >
		</td>  -->

					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;">
						<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
									<a href="javascript:fncGetProductList('1');">검색</a></td>
						////////////////////////////////////////////////////////////////////////////////////////////////// -->
						검색
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<%-- 
		<td colspan="11" >
		전체  <%= resultPage.getTotalCount() %> 건수, 현재 <%= resultPage.getCurrentPage() %> 페이지
		</td>
		--%>
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재
						${resultPage.currentPage} 페이지</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">
						상품명<br>
						<h7>(상품명 click:상세정보)</h7>
					</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>

				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
	<%
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
			System.out.println(vo.getProdNo());
	%>
	<tr class="ct_list_pop">
		<td align="center"><%=i + 1%></td>
		<td></td>
		<td align="left">
			<% if(menu.equals("search")){%>
			<a href="/getProduct.do?menu=search&prodNo=<%=vo.getProdNo() %>"><%= vo.getProdName() %></a>
			<%} else if(menu.equals("manage")){%>
			<a href="/updateProductView.do?menu=manage&prodNo=<%=vo.getProdNo() %>"><%= vo.getProdName() %></a>
			<%}%>
		</td>
		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getRegDate() %>
		</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop">
						<td align="center">${ i }</td>
						<td></td>
						<td class="pp" align="left" prodNo="${product.prodNo}">
							<!-- ////////////////// jQuery Event 처리로 변경됨 //////////////////////////////////////////////////		
			<a href="/product/getProduct?menu=search&prodNo=${product.prodNo}">${product.prodName}</a>
			<a href="/product/getProduct?menu=manage&prodNo=${product.prodNo}">${product.prodName}</a>
		////////////////////////////////////////////////////////////////////////////////////////////////// -->
							${product.prodName}
						</td>
						<td></td>
						<td align="left">${product.price}</td>
						<td></td>
						<td align="left">${product.regDate}</td>
					</tr>
					<tr>
						<!-- //////////////////////////// 추가 , 변경된 부분 /////////////////////////////
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
						////////////////////////////////////////////////////////////////////////////////////////////-->
						<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> 
			<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// 		   
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{%>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
		/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
						<jsp:include page="../common/pageNavigator.jsp" /></td>
				</tr>
			</table>
			<!--  페이지 Navigator 끝 -->
		</form>
	</div>

</body>
</html>