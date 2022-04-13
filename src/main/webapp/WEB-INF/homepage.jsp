<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 405fu
  Date: 8.03.2022
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%@ page pageEncoding="UTF-8" %>--%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js">
    </script>
</head>
<body style="background: #ececec;">

<div>
    <%@include file='../template.jsp' %>
</div>


<div style="margin-left:20%; padding: 10px;">

<%--    <c:if test="${list != null}">--%>
<%--        <h1>LIST ITEMS</h1>--%>
<%--        <c:forEach items="${list}" var="item">--%>
<%--            <div>--%>
<%--                <h2>--%>
<%--                    <c:out value="${item.getAd()} ${item.getSoyad()}"/>--%>
<%--                </h2>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </c:if>--%>


<%--    <h1><c:out value="${karsilama}"/></h1>--%>
<%--&lt;%&ndash;    <h2>${kisiKarsilama}</h2>&ndash;%&gt;--%>
<%--    <h2><spring:message code="aciklama"/></h2>--%>
<%--    <p> Dil Tercihi: <a href="${pageContext.request.contextPath}?lang=tr_TR">Türkçe</a> | <a--%>
<%--            href="${pageContext.request.contextPath}?lang=en_US">İngilizce</a></p>--%>
<%--    <p>Mevcut Locale: ${pageContext.response.locale} / ${locale} </p>--%>

    <div class="w3-col">

        <div class="w3-row-padding">
            <div class="w3-col m12">
                <div class="w3-card w3-round w3-white">
                    <div class="w3-container">

                        <%--                        POST GÖNDERİMİ--%>
                        <form id="formPost" action="${pageContext.request.contextPath}/post/create" method="post">
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Başlık" id="postTitle">
                            </div>
                            <div>
                                <textarea required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                          rows="10" placeholder="İçerik" id="postContext"></textarea>
                            </div>
                            <div>
                                <select required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                        placeholder="Kategori Seç" id="category">

                                </select>
                            </div>
                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Post
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="recordListContainer">

        </div>

        <script>

            $(document).ready(function () {
                getPostByCurrentUser();

                $.get("${pageContext.request.contextPath}/category/getAll", function (data) {
                    var result = JSON.parse(data);
                    if (result.success == true) {
                        var list = result.data;

                        list.map(item =>
                            $('#category').append('<option value="' + item.id + '">' + item.name + '</option>')
                        );
                    }
                });
            });

            $("#formPost").submit(function (event) {
                event.preventDefault();
                $.post("${pageContext.request.contextPath}/post/create", {
                    "title": $("#postTitle").val(),
                    "context": $("#postContext").val(),
                    "categoryID": $("#category").val()
                }, function (data, status, xhr) {
                    var result = JSON.parse(data);
                    if (status == "success" && result.success == true) {
                        $("#postTitle").val("");
                        $("#postContext").val("");
                        getPostByCurrentUser();
                    }
                });

            });

            function getPostByCurrentUser() {
                $('#recordListContainer').empty();

                $.get("${pageContext.request.contextPath}/post/getByCurrentUser", function (data) {
                    var recordList = JSON.parse(data)
                    recordList.map(record =>
                        $('#recordListContainer').append(
                            '<div class="w3-container w3-card w3-white w3-round w3-margin"><br>' +
                            '<span class="w3-right w3-opacity">' + record.creationTime + '</span>' +
                            '<h4>' + (record.isResolved ?  '[ÇÖZÜLDÜ] ' : '') + record.title + '</h4><br>' +
                            '<hr class="w3-clear">' +
                            '<p>' + (record.context?.length > 400 ? record.context.substr(0, 397) + '...': record.context) + '</p>' +
                            '<div class="w3-row-padding" style="margin:0 -16px">' +
                            '<div class="w3-half">' + '</div><div class="w3-half">' +
                            '</div></div>' +
                            '<a href="${pageContext.request.contextPath}/post/detay/' + record.id + '"><button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i> &nbsp;Detay</button></a>' +
                            // '<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i> &nbsp;Düzenle</button>' +
                            '</div>'
                        )
                    )
                });
            }
        </script>

    </div>

</div>

</body>
</html>
