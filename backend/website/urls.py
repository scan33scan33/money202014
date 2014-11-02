from django.conf.urls import patterns, url

from website import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^handle$', views.index, name='bid_request'),
)
