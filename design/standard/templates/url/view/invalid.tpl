<form method="post" action={concat("url/list/invalid",$view_parameters.offset|gt(0)|choose("",array("/offset/",$view_parameters)))|ezurl}>
{let url_limit=10
     url_count=fetch('url','list_count',hash(is_valid,false()))
     url_list=fetch('url','list',hash(is_valid,false(),offset,$view_parameters.offset,limit,$url_limit))}
<h1>{'Invalid URLs'|i18n('design/standard/url')}</h1>
{include uri="design:url/header.tpl" current_view_id='invalid'}

{include uri="design:url/url_list.tpl"
         url_list=$url_list url_count=$url_count
         view_parameters=$view_parameters
         show_make_valid=true()
         show_make_invalid=false()
         current_view_id='invalid'}

{/let}
</form>
