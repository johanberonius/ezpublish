{section show=or( $not_removed, $ini_not_saved )}
<div class="message-error">
<h2><span class="time">[{currentdate()|l10n( shortdatetime )}]</span> {'Removing of selected template overrides unsuccessful'|i18n( 'design/admin/visual/templateview' )}</h2>

{section show=$not_removed}
<p>{'The following files and corresponding overrides could not be removed because of insufficient permissions:'|i18n( 'design/admin/visual/templateview' )}</p>
<ul>

{section var=item loop=$not_removed}
    <li>{$item.filename}</li>
{/section}

</ul>
{/section}

{section show=$ini_not_saved}
<p>{'The override.ini file could not be modified because of insufficient permissions.'|i18n( 'design/admin/visual/templateview' )}</p>
{/section}

</div>
{/section}


<form method="post" name="templateview" action={concat( '/visual/templateview', $template_settings.template )|ezurl}>

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Overrides for <%template_name> template in <%current_siteaccess> siteaccess [%override_count]'|i18n( 'design/admin/visual/templateview',, hash( '%template_name', $template_settings.template, '%current_siteaccess', $current_siteaccess, '%override_count', $template_settings.custom_match|count ) )|wash}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

<div class="context-attributes">

<div class="block">
<label>{'Default template resource'|i18n( 'design/admin/visual/templateview' )}:</label>
{$template_settings.base_dir}
</div>


<div class="block">
<label>{'Siteaccess'|i18n( 'design/admin/visual/templateview' )}:</label>

<select name="CurrentSiteAccess">
{section name=SiteAccess loop=ezini('SiteAccessSettings','AvailableSiteAccessList')}
    {section show=eq($current_siteaccess,$:item)}
        <option value="{$SiteAccess:item}" selected="selected">{$:item}</option>
    {section-else}
        <option value="{$SiteAccess:item}">{$:item}</option>
    {/section}
{/section}
</select>

<input class="button" type="submit" name="SelectCurrentSiteAccessButton" value="{'Set'|i18n( 'design/admin/visual/templateview' )}" />
</div>

{section show=$template_settings.custom_match}

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/visual/templateview' )}" title="{'Invert selection.'|i18n( 'design/admin/visual/templateview' )}" onclick="ezjs_toggleCheckboxes( document.templateview, 'RemoveOverrideArray[]' ); return false;" /></th>
    <th>{'Name'|i18n( 'design/admin/visual/templateview' )}</th>
    <th>{'File'|i18n( 'design/admin/visual/templateview' )}</th>
    <th>{'Match conditions'|i18n( 'design/admin/visual/templateview' )}</th>
    <th class="tight">{'Priority'|i18n( 'design/admin/visual/templateview' )}</th>
    <th class="tight">&nbsp;</th>
</tr>
{section var=CustomMatch loop=$template_settings.custom_match sequence=array( bglight, bgdark )}
<tr class="{$CustomMatch.sequence}">
    <td><input type="checkbox" name="RemoveOverrideArray[]" value="{$CustomMatch.item.override_name}" /></td>
    <td>{$CustomMatch.item.override_name}</td>

    {section show=$CustomMatch.item.match_file}
    <td>{$CustomMatch.item.match_file}</td>
    {section-else}
    <td><i>{'No file matched'|i18n( 'design/admin/visual/templateview' )}</i></td>
    {/section}

    <td>
        {section show=is_set( $CustomMatch.item.conditions )}
            {section name=Condition  loop=$CustomMatch.item.conditions}
            {$:key} : {$:item}
            {delimiter}
            <br />
            {/delimiter}
            {/section}
	{/section}
    </td>
    <td><input type="text" name="PriorityArray[{$CustomMatch.item.override_name}]" size="2" value="{$CustomMatch.number}" /></td>

    {section show=$CustomMatch.item.match_file}
    <td><a href={concat( '/visual/templateedit/', $CustomMatch.item.match_file)|ezurl} title="{'Edit override template.'|i18n( 'design/admin/visual/templateview' )}"><img src={'edit.png'|ezimage} alt="Edit" /></a></td>
    {section-else}
    <td><img src={'edit_disabled.png'|ezimage} alt="" /></td>
    {/section}

</tr>
{/section}
</table>

{section-else}
<div class="block">
<p>{'There are no overrides for the <%template_name> template.'i18n( 'design/admin/visual/templateview',, hash( '%template_name', $template_settings.template ) )|wash}</p>
</div>
{/section}

</div>

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
    <div class="block">
        {section show=$template_settings.custom_match}
        <input class="button" type="submit" name="RemoveOverrideButton" value="{'Remove selected'|i18n( 'design/admin/visual/templateview' )}" title="{'Remove selected template overrides.'|i18n( 'design/admin/visual/templateview' )}" />
        {section-else}
        <input class="button-disabled" type="submit" name="RemoveOverrideButton" value="{'Remove selected'|i18n( 'design/admin/visual/templateview' )}" disabled="disabled"/>
        {/section}

        <input class="button" type="submit" name="NewOverrideButton" value="{'New override'|i18n( 'design/admin/visual/templateview' )}" title="{'Create a new template override.'|i18n( 'design/admin/visual/templateview' )}" />
        <div class="right">
            {section show=$template_settings.custom_match}
            <input class="button" type="submit" name="UpdateOverrideButton" value="{'Update priorities'|i18n( 'design/admin/visual/templateview' )}" />
            {section-else}
            <input class="button-disabled" type="submit" name="UpdateOverrideButton" value="{'Update priorities'|i18n( 'design/admin/visual/templateview' )}" disabled="disabled"/>
            {/section}
        </div>
    </div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</div>

</form>
