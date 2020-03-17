describe("Link Prevent Default elm/browser#74", function() {
  before(function() {
    browser.url("/src/LinkPreventDefault.elm");
    $("#link-prevent-default").waitForExist();
  });


  it("increments and decrements", function() {
    $("#click-me").click();

    browser.waitUntil(() => $("#clicked").getText() === "yes");

    expect($("#current-url").getText()).to.not.include("#click-me");
  });
});
