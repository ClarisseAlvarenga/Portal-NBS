function highlightButton() {
    var urlParams = new URLSearchParams(location.search);

    if (urlParams.has('commit')) {
        document.getElementsByName('commit')[0].classList.add('active');
    } else if (urlParams.has('pref')) {
        document.getElementsByName('pref')[0].classList.add('active');
    }
}


function shareResultsGenerator() {
    var URL = document.URL;

    var email_link = document.getElementById("share_email_results");
    var twitter_link = document.getElementById("share_twitter_results");
    var linkedin_link = document.getElementById("share_linkedin_results");

    if (email_link && twitter_link && linkedin_link) {
        var email_title = "Busca na NBS";
        var message = "Resultados%20para%20a%20busca%20na%20NBS%20"

        email_link.href = "mailto:?Subject=" + email_title + "&amp;Body=" + message + URL;
        twitter_link.href = "https://twitter.com/share?url=" + URL + "&amp;text=" + message + "&amp;hashtags=nbs"
        linkedin_link.href = "http://www.linkedin.com/shareArticle?mini=true&amp;url=" + URL;

        highlightButton();
    }
}

$(document).ready(shareResultsGenerator());