from django.conf.urls import patterns, include, url
from django.conf.urls.static import static
from django.conf import settings
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ubivend.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^website/', include('website.urls')),
    url(r'^handle/', 'website.views.bid_request'),
    url(r'^can_transfer_money/', 'website.views.can_transfer_money'),
    url(r'^get_cap/', 'website.views.get_cap'),
    url(r'^get_money/', 'website.views.get_money'),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^static/(?P<path>.*)$', 'django.views.static.serve',
      {'document_root', settings.STATIC_ROOT}
    ),
)
