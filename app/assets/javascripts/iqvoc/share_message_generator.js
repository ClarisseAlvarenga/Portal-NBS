function shareMessageGenerator() {
    var URL = document.URL;

    var email_link = document.getElementById("share_email");
    var twitter_link = document.getElementById("share_twitter");
    var linkedin_link = document.getElementById("share_linkedin");

    if (email_link && twitter_link && linkedin_link) {   
        var email_title = "Meu Serviço na NBS";
        var message = "Conheça%20o%20serviço%20"
        
        email_link.href = "mailto:?Subject=" + email_title + "&amp;Body="+ message + " " + URL;
        twitter_link.href = "https://twitter.com/share?url="+ URL + "&amp;text="+ message + "&amp;hashtags=nbs"
        linkedin_link.href = "http://www.linkedin.com/shareArticle?mini=true&amp;url=" + URL;
    }
}

$( document ).ready(shareMessageGenerator());