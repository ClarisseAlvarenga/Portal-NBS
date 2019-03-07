function shareMessageGenerator() {
    var URL = document.URL;

    var email_link = document.getElementById("share_email");
    var twitter_link = document.getElementById("share_twitter");
    var linkedin_link = document.getElementById("share_linkedin");
    var whatsappweb_link = document.getElementById("whatsappweb");
    var whatsappmobile_link = document.getElementById("whatsappmobile");

    if (email_link && twitter_link && linkedin_link) {
        var email_title = "Meu Serviço na NBS";
        var message = "Saiba%20mais%20sobre%20este%20servi%C3%A7o%20da%20Nomenclatura%20Brassileira%20de%20Servi%C3%A7os%3A%20"

        email_link.href = "mailto:?Subject=" + email_title + "&amp;Body=" + message + " " + URL;
        twitter_link.href = "https://twitter.com/share?url=" + URL + "&amp;text=" + message + "&amp;hashtags=nbs"
        linkedin_link.href = "http://www.linkedin.com/shareArticle?mini=true&amp;url=" + URL;
        whatsappweb_link.href = "https://web.whatsapp.com/" + "send?text=" + message + URL;
        whatsappmobile_link.href = "whatsapp://send?text=" + message + URL;
    }
}

$(document).ready(function () {

    shareMessageGenerator()
    var isMobile = {
        Android: function () {
            return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function () {
            return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function () {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function () {
            return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function () {
            return navigator.userAgent.match(/IEMobile/i);
        },
        any: function () {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
    };
    if (isMobile.any()) {
        /* var text = $(this).attr("data-text");
        var url = $(this).attr("data-link");
        var message = encodeURIComponent(text) + " - " + encodeURIComponent(url);
        var whatsapp_url = "whatsapp://send?text=" + message;
        window.location.href = whatsapp_url; */
        console.log('entrou');
        var buttom = document.getElementById("whatsappweb");
        buttom.style.display = "none";

    } else {
        console.log('entrou');
        var buttom = document.getElementById("whatsappmobile");
        buttom.style.display = "none";
/*             alert("Please share this article in mobile device");
*/        }
});