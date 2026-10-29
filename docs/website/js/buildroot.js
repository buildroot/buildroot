const NB_ACTIVITY = 8;

function display_activity(container, items) {
    if (container == null) return;
    for (let i = 0; i < NB_ACTIVITY; i++) {
        let p = document.createElement("p");
        p.className = "text-truncate mb-2";
        p.textContent = "\u00a0";
        if (i < items.length) {
            p.textContent = "";
            let link = document.createElement("a");
            let d = new Date(items[i].date);
            link.textContent = '[' + d.toLocaleDateString() + '] ' + items[i].title;
            link.title = items[i].title;
            link.href = items[i].url;
            p.appendChild(link);
        }
        container.appendChild(p);
    }
}

function load_commit_activity(apiurl) {
    let container = document.getElementById("commit-activity");
    if (container == null) return;
    $.ajax({
        url: apiurl,
        dataType: "json"
    })
    .done(function(commits) {
        display_activity(container, commits.map(function(c) {
            return { date: c.committed_date, title: c.title, url: c.web_url };
        }));
    });
}

function load_mailing_list_activity(feedurl) {
    let container = document.getElementById("mailing-list-activity");
    if (container == null) return;
    $.ajax({
        url: feedurl,
        dataType: "xml"
    })
    .done(function(feed) {
        let items = [];
        $(feed).find("entry").slice(0, NB_ACTIVITY).each(function() {
            let title = $(this).children("title").text();
            items.push({
                date: $(this).children("updated").text(),
                title: title.replace("Re: ", "").replace("[Buildroot] ", ""),
                url: $(this).children("link").attr("href")
            });
        });
        display_activity(container, items);
    });
}

function google_analytics() {
    let _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-21761074-1']);
    _gaq.push(['_setDomainName', 'none']);
    _gaq.push(['_setAllowLinker', true]);
    _gaq.push(['_trackPageview']);

    let ga = document.createElement('script');
    ga.type = 'text/javascript';
    ga.async = true;
    ga.src = ('https:' === document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    let s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(ga, s);
}

let clipboard = new Clipboard('.btn');

clipboard.on('success', function(e) {
    e.clearSelection();
    let tooltip = bootstrap.Tooltip.getOrCreateInstance(e.trigger);
    tooltip.show();
    setTimeout(function() { tooltip.hide(); }, 1500);
});

$(function() {
  $('a[href*=\\#]:not([href=\\#])').click(function() {
    if (location.pathname.replace(/^\//,'') === this.pathname.replace(/^\//,'') && location.hostname === this.hostname) {
        let target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top - $('.navbar').outerHeight()
        }, 1000);
        return false;
      }
    }
  });
});

jQuery(document).ready(function($) {
    let url = window.location.href;
    // Get the basename of the URL
    url = url.split(/[\\/]/).pop();
    $('.navbar-nav a.nav-link[href="/' + url + '"]').addClass('active bg-light');

    load_commit_activity("https://gitlab.com/api/v4/projects/buildroot.org%2Fbuildroot/repository/commits?ref_name=master&per_page=" + NB_ACTIVITY);
    load_mailing_list_activity("/new.atom");

    $('#slides').html('<iframe src="https://docs.google.com/gview?url=http://bootlin.com/doc/training/buildroot/buildroot-slides.pdf&embedded=true" style="position:absolute; width:100%; height:100%; top:0; left:0;" frameborder="0"></iframe>')
});
