{default with_children=true()
         is_editable=true()
	 is_standalone=true()}
{let page_limit=3
     list_count=and($with_children,fetch('content','list_count',hash(parent_node_id,$node.node_id)))}

{default content_object=$node.object
         content_version=$node.contentobject_version_object
         node_name=$node.name}

{section show=$assignment}
  {node_view_gui view=full with_children=false() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$assignment.temp_node node=$node}
{/section}
<form method="post" action={concat("content/versionview/",$object.id,"/",$object_version,"/",$language|not|choose(array($language,"/"),""))|ezurl}>

<div class="block">
{section show=$version.language_list|gt(1)}
<div class="element">
<label>{"Translation"|i18n("design/standard/content/view")}</label><div class="labelbreak"></div>
  
<select name="SelectedLanguage" >
{section name=Translation loop=$version.language_list}
<option value="{$Translation:item.locale.locale_code}" {section show=eq($Translation:item.locale.locale_code,$object_languagecode)}selected="selected"{/section}>{$Translation:item.locale.intl_language_name}</option>
{/section}
</select>
</div>

{/section}
{let name=Placement node_assignment_list=$version.node_assignments}
{section show=$Placement:node_assignment_list|gt(1)}

<div class="element">
<label>{"Placement"|i18n("design/standard/content/view")}</label><div class="labelbreak"></div>

<select name="SelectedPlacement" >
{section loop=$Placement:node_assignment_list}
<option value="{$Placement:item.id}" {section show=eq($Placement:item.id,$placement)}selected="selected"{/section}>{$Placement:item.parent_node_obj.name|wash}</option>
{/section}
</select>
</div>

{/section}
{/let}
  
{let name=Sitedesign
   sitedesign_list=fetch('layout','sitedesign_list')}
{section show=$Sitedesign:sitedesign_list|gt(1)}

<div class="element">
<label>{"Site Design"|i18n("design/standard/content/view")}</label><div class="labelbreak"></div>

<select name="SelectedSitedesign" >
{section loop=$Sitedesign:sitedesign_list}
<option value="{$Sitedesign:item}" {section show=eq($Sitedesign:item,$sitedesign)}selected="selected"{/section}>{$Sitedesign:item|wash}</option>
{/section}
</select>
</div>

{/section}
{/let}
<div class="break"></div>
</div>

<div class="buttonblock">
<input class="button" type="submit" name="ChangeSettingsButton" value="{'Change'|i18n('design/standard/content/view')}" />
</div>

<input type="hidden" name="ContentObjectID" value="{$object.id}" />
<input type="hidden" name="ContentObjectVersion" value="{$object_version}" />
<input type="hidden" name="ContentObjectLanguageCode" value="{$object_languagecode}" />
<input type="hidden" name="ContentObjectPlacementID" value="{$placement}" />

<div class="buttonblock">
{section show=and(eq($version.status,0),$is_creator,$object.can_edit)}
<input class="button" type="submit" name="PreviewPublishButton" value="{'Publish'|i18n('design/standard/content/view')}" />
<input class="button" type="submit" name="EditButton" value="{'Edit'|i18n('design/standard/content/view')}" />
{/section}

<input class="button" type="submit" name="VersionsButton" value="{'Versions'|i18n('design/standard/content/view')}" />
</div>

{section show=eq($node.node_id,"")}
{set with_children=false()}
{/section}

{section show=$with_children}

{let name=Child
     children=fetch('content','list',hash(parent_node_id,$node.node_id,sort_by,$node.sort_array,limit,$page_limit,offset,$view_parameters.offset))
     can_remove=false() can_edit=false() can_create=false() can_copy=false()}

{section show=$:children}

{section loop=$:children}
  {section show=$:item.object.can_remove}
    {set can_remove=true()}
  {/section} 
  {section show=$:item.object.can_edit}
    {set can_edit=true()}
  {/section} 
  {section show=$:item.object.can_create}
    {set can_create=true()}
  {/section} 
{/section}

{set can_copy=$content_object.can_create}


<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    {section show=$:can_remove}
    <th width="1">
&nbsp;
    </th>
    {/section}
    <th>
      {"Name"|i18n("design/standard/node/view")}
    </th>
    <th>
      {"Class"|i18n("design/standard/node/view")}
    </th>
    <th>
      {"Section"|i18n("design/standard/node/view")}
    </th>
    {section show=eq($node.sort_array[0][0],'priority')}
    <th>
      {"Priority"|i18n("design/standard/node/view")}
    </th>
    {/section}
    {section show=$:can_edit}
    <th width="1">
      {"Edit"|i18n("design/standard/node/view")}
    </th>
    {/section}
    {section show=$:can_copy}
    <th width="1">
      {"Copy"|i18n("design/standard/node/view")}
    </th>
    {/section}
</tr>
{section loop=$:children sequence=array(bglight,bgdark)}
<tr class="{$Child:sequence}">
        {section show=$:can_remove}
	<td align="right" width="1">
	{section show=$:item.object.can_remove}
             <input type="checkbox" name="DeleteIDArray[]" value="{$Child:item.node_id}" />
        {/section} 
	</td>
        {/section} 
	<td>
        <a href={concat('content/view/full/',$:item.node_id)|ezurl}>{node_view_gui view=line content_node=$:item}</a>

{*        {node_view_gui view=line content_node=$:item} *}
	</td>
    <td>
        {$Child:item.object.class_name|wash}
	</td>
    <td>
        {$Child:item.object.section_id}
	</td>
	{section show=eq($node.sort_array[0][0],'priority')}
	<td width="40" align="left">
	    <input type="text" name="Priority[]" size="2" value="{$Child:item.priority}">
        <input type="hidden" name="PriorityID[]" value="{$Child:item.node_id}">
	</td>
	{/section}

        {section show=$:can_edit}
            <td width="1">
                {section show=$:item.object.can_edit}
                    <a href={concat("content/edit/",$Child:item.contentobject_id)|ezurl}><img src={"edit.png"|ezimage} alt="Edit" /></a>
                {/section}
            </td>
        {/section}
        {section show=$:can_copy}
        <td>
          <a href={concat("content/copy/",$Child:item.contentobject_id)|ezurl}><img src={"copy.gif"|ezimage} alt="{'Copy'|i18n('design/standard/node/view')}" /></a>
        </td>
        {/section}

</tr>
{/section}
</table>

    {section show=eq($node.sort_array[0][0],'priority')}
      {section show=and($content_object.can_edit,eq($node.sort_array[0][0],'priority'))}
         <input class="button" type="submit"  name="UpdatePriorityButton" value="{'Update'|i18n('design/standard/node/view')}" />
      {/section}
    {/section}
    {section show=$:can_edit}
    {/section}
    {section show=$:can_copy}
    {/section}
    {section show=$:can_remove}
    {section show=fetch('content','list',hash(parent_node_id,$node.node_id,sort_by,$node.sort_array,limit,$page_limit,offset,$view_parameters.offset))}
                <input type="submit" name="RemoveButton" value="Remove" />
    {/section}
    {/section}


{/section}
{/let}

{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/versionview/',$object.id,"/",$object_version)
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}


{/section}


</form>
