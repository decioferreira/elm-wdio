describe("Quick Sample", function() {
  before(function() {
    browser.url("/src/QuickSample.elm");
  });

  it("title", function() {
    $("#quick-sample").waitForExist();

    expect(browser.getTitle()).to.equal("QuickSample");
  });
});
