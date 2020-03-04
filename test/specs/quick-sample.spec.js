describe("Quick Sample", function() {
  before(function() {
    browser.url("/src/QuickSample.elm");
    $("#quick-sample").waitForExist();
  });

  it("title", function() {
    expect(browser.getTitle()).to.equal("QuickSample");
  });

  it("increments and decrements", function() {
    expect($("#count").getText()).to.equal("0");

    $("#increment").click();

    expect($("#count").getText()).to.equal("1");

    $("#decrement").click();
    $("#decrement").click();

    expect($("#count").getText()).to.equal("-1");
  });
});
