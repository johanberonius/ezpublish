{*?template charset=latin1?*}
{default enable_glossary=true() enable_help=true() enable_print=true()}

<link rel="Home" href={"/"|ezurl} title="{'%sitetitle front page'|i18n('design/standard/layout',,hash('%sitetitle',$site.title))}" />
<link rel="Index" href={"/"|ezurl} />
<link rel="Top"  href={"/"|ezurl} title="{$site_title}" />
<link rel="Search" href={"content/advancedsearch"|ezurl} title="{'Search %sitetitle'|i18n('design/standard/layout',,hash('%sitetitle',$site.title))}" />
<link rel="Shortcut icon" href={"favicon.ico"|ezimage} type="image/x-icon" />
<link rel="Copyright" href={"/ezinfo/copyright"|ezurl} />
<link rel="Author" href={"/ezinfo/about"|ezurl} />

{section show=$enable_glossary}
<link rel="Help" href={"manual"|ezurl} />
{/section}
{section show=$enable_glossary}
<link rel="Glossary" href={"sdk"|ezurl} />
{/section}

{section show=$enable_print}
<link rel="Alternate" href={concat("layout/set/print/",$site.uri.tail)|ezurl} media="print" title="{'Printable version'|i18n('design/standard/layout')}" />
{/section}

{/default}