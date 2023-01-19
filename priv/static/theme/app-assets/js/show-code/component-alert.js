const examplesAlert = `
<div class="alert alert-primary" role="alert">
    A simple primary alert—check it out!
</div>

<div class="alert alert-secondary" role="alert">
    A simple secondary alert—check it out!
</div>

<div class="alert alert-success" role="alert">
    A simple success alert—check it out!
</div>

<div class="alert alert-danger" role="alert">
    A simple danger alert—check it out!
</div>

<div class="alert alert-warning" role="alert">
    A simple warning alert—check it out!
</div>

<div class="alert alert-info" role="alert">
    A simple info alert—check it out!
</div>

<div class="alert alert-light" role="alert">
    A simple light alert—check it out!
</div>

<div class="alert alert-dark mb-0" role="alert">
    A simple dark alert—check it out!
</div>

`;

const linkColor = `
<div class="alert alert-primary" role="alert">
    A simple primary alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-secondary" role="alert">
  A simple secondary alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-success" role="alert">
    A simple success alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-danger" role="alert">
    A simple danger alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-warning" role="alert">
    A simple warning alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-info" role="alert">
    A simple info alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-light" role="alert">
    A simple light alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

<div class="alert alert-dark" role="alert">
    A simple dark alert with <a href="javascript:;" class="alert-link">an example link</a>. Give it a click if you like.
</div>

`;

const additional = `
<div class="alert alert-success" role="alert">
    <h4 class="alert-heading hp-text-color-dark-info-1">Well done!</h4>
    <p>Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.</p>
    <div class="divider hp-border-color-dark-info-1"></div>
    <p class="mb-0">Whenever you need to, be sure to use margin utilities to keep things nice and tidy.</p>
</div>

`;

const iconsAlert = `
<div class="alert alert-primary d-flex align-items-center" role="alert">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
    </svg>

    <div>
        An example alert with an icon
    </div>
</div>

`;

const icons2Alert = `
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
  </symbol>

  <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
  </symbol>

  <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
      <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
  </symbol>
</svg>

<div class="alert alert-primary d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>

  <div>
      An example alert with an icon
  </div>
</div>

<div class="alert alert-success d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>

      <div>
      An example success alert with an icon
  </div>
</div>

<div class="alert alert-warning d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>

  <div>
      An example warning alert with an icon
  </div>
</div>

<div class="alert alert-danger d-flex align-items-center" role="alert">
  <svg class="bi flex-shrink-0 me-8" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>

  <div>
      An example danger alert with an icon
  </div>
</div>

`;

const dismissing = `
<div class="alert alert-warning alert-dismissible fade show" role="alert">
    <strong>Holy guacamole!</strong> You should check in on some of those fields below.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>

`;

//--

$("pre code").each(function () {
  if ($(this).data("component") === "alert") {
    $(this).text($.trim($(this).data("code")))

    if ($(this).data("code") === "examples") {
      $(this).text(examplesAlert)
    }

    if ($(this).data("code") === "link-color") {
      $(this).text(linkColor)
    }

    if ($(this).data("code") === "additional") {
      $(this).text(additional)
    }

    if ($(this).data("code") === "icons") {
      $(this).text(iconsAlert)
    }

    if ($(this).data("code") === "icons2") {
      $(this).text(icons2Alert)
    }

    if ($(this).data("code") === "dismissing") {
      $(this).text(dismissing)
    }
  }
});
