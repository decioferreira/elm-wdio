describe("Html.map + blur event elm/virtual-dom#103", function() {
  before(function() {
    browser.url("/src/HtmlMapBlur.elm");
    browser.captureConsoleLogs();
    $("#html-map-blur").waitForExist();
  });

  it("no impossible messages", function() {
    $("#go-to-b").click();

    expect(browser.consoleLogs()).to.not.include(
      "( msg, model ): (MsgB BlurA,B)"
    );
  });
});
