{*?template charset=latin1?*}
{include uri='design:setup/setup_header.tpl' setup=$setup}

<form method="post" action="{$script}">

<p>
 {"What kind of language support should this site have. The type of support determines the language selection and charset."|i18n("design/standard/setup/init")}
</p>

<div class="highlight">
<table cellspacing="0" cellpadding="0" border="0">
<tr>
  <td class="normal">
    {"Monolingual (one language)"|i18n("design/standard/setup/init")}
  </td>
  <td class="normal">
    <input type="radio" name="eZSetupLanguageType" value="1" {section show=eq($regional_info.language_type,1)}checked="checked"{/section} />
  </td>
</tr>
<tr>
  <td class="normal">
    {"Multilingual (multiple languages with one charset)"|i18n("design/standard/setup/init")}
  </td>
  <td class="normal">
    <input type="radio" name="eZSetupLanguageType" value="2" {section show=eq($regional_info.language_type,2)}checked="checked"{/section} />
  </td>
</tr>
{section show=$database_info.supports_unicode}
<tr>
  <td class="normal">
    {"Multilingual (Unicode, no limit)"|i18n("design/standard/setup/init")}
  </td>
  <td class="normal">
    <input type="radio" name="eZSetupLanguageType" value="3" {section show=eq($regional_info.language_type,3)}checked="checked"{/section} />
  </td>
</tr>
{/section}
</table>
</div>

  <div class="buttonblock">
    <input type="hidden" name="ChangeStepAction" value="" />
    <input class="defaultbutton" type="submit" name="StepButton_6" value="{'Regional Options'|i18n('design/standard/setup/init')} >>" />
  </div>
  {include uri='design:setup/persistence.tpl'}
</form>
