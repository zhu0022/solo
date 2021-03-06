<link type="text/css" rel="stylesheet" href="${staticServePath}/plugins/symphony-news-getter/style.css"/>
<div id="symphonyNewsGetterPanel">
    <div class="module-panel">
        <div class="module-header">
            <h2>${b3logAnnounceLabel}</h2>
        </div>
        <div class="module-body padding12">
            <div id="symphonyNewsGetter">
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    plugins.symphonyNewsGetter = {
        init: function () {
            $("#loadMsg").text("${loadingLabel}");
            
            $("#symphonyNewsGetter").css("background",
            "url(${staticServePath}/images/loader.gif) no-repeat scroll center center transparent");
            
            $.ajax({
                url: "http://symphony.b3log.org:80/get-news",
                type: "GET",
                dataType:"jsonp",
                jsonp: "callback",
                error: function(){
                    $("#symphonyNewsGetter").html("Loading B3log Announcement failed :-(").css("background", "none");
                },
                success: function(data, textStatus){
                    var articles = data.articles;
                    if (0 === articles.length) {
                        return;
                    }
            
                    var listHTML = "<ul>";
                    for (var i = 0; i < articles.length; i++) {
                        var article = articles[i];
                        var articleLiHtml = "<li>"
                            + "<a target='_blank' href='" + article.articlePermalink + "'>"
                            +  article.articleTitle + "</a>&nbsp; <span class='date'>" + $.bowknot.getDate(article.articleCreateDate, 1); + "</span></li>"
                        listHTML += articleLiHtml
                    }
                    listHTML += "</ul>";
                    
                    $("#symphonyNewsGetter").html(listHTML).css("background", "none");
                }
            });
            
            $("#loadMsg").text("");
        }
    };
    
    /*
     * ????????????
     */
    admin.plugin.add({
        "id": "symphonyNewsGetter",
        "path": "/main/panel1",
        "content": $("#symphonyNewsGetterPanel").html()
    });
    
    // ??????????????????
    $("#symphonyNewsGetterPanel").remove();
</script>
