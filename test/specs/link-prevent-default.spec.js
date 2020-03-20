describe("Link Prevent Default elm/browser#74", function() {
  beforeEach(function() {
    browser.url("/src/LinkPreventDefault.elm");
    $("#link-prevent-default").waitForExist();
  });

  it("prevents default", function() {
    $("#click-me").click();

    browser.waitUntil(() => $("#clicked").getText() === "yes");

    expect($("#current-url").getText()).to.not.include("#click-me");
  });

  it("known workaround", function() {
    $("#workaround").click();

    browser.waitUntil(() => $("#clicked").getText() === "yes");

    expect($("#current-url").getText()).to.not.include("#workaround");
  });
});
