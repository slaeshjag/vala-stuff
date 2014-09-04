public class MailWebView : Gtk.ScrolledWindow {
	public WebKit.WebView webview;
	private bool external_res = false;
	private bool allow_external = false;

	/* This signal is triggered if a remote resource access was denied */
	public signal void rejected_access();
	/* This signal is emitted whenever a link is clicked */
	public signal void navigate_to(string uri);

	private bool decide_load_policy(WebKit.WebFrame frame, WebKit.NetworkRequest req, WebKit.WebNavigationAction action, WebKit.WebPolicyDecision dec) {
		dec.ignore();
		this.navigate_to(req.uri);
		return true;
	}


	private void decide_resource_load(WebKit.WebFrame frame, WebKit.WebResource res, WebKit.NetworkRequest req, WebKit.NetworkResponse? resp) {
		if (res.uri != "" && !this.allow_external) {
			if (!external_res)
				this.rejected_access();
			req.uri = "about:blank";
			external_res = true;
		}
	}


	private void set_access_policy() {
		this.webview.settings.enable_plugins = false;
		this.webview.settings.enable_scripts = false;
		this.webview.settings.enable_private_browsing = true;
		this.webview.navigation_policy_decision_requested.connect(this.decide_load_policy);
		this.webview.resource_request_starting.connect(this.decide_resource_load);
	}


	private void new_view() {
		this.webview = new WebKit.WebView();
		set_access_policy();
		this.add(this.webview);
	}

	private void reset_view() {
		if (this.webview != null)
			this.remove(this.webview);
		this.webview = null;
		this.new_view();
		this.webview.show_all();
	}

	public MailWebView() {
		this.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
	}

	public void view_string(string content, bool allow_external) {
		this.allow_external = allow_external;
		this.reset_view();
		this.webview.load_string(content, "text/html", "utf-8", "");
	}


	public void clear_view() {
		this.reset_view();
	}



}

/*
class Demo.HelloWorld : GLib.Object {
	
	public static int main(string[] args) {
		Gtk.init(ref args);
		var window = new Gtk.Window();
		var webtest = new MailWebView();
		window.add(webtest);
		window.title = "Webtest";
		window.show_all();


		string test_doc = "<html><head><title>arne</title></head><body bgcolor=\"#f00\"><p>Arne</p><img src=\"http://i.rdw.se/c66.jpg\"><a href='http://i.rdw.se'>Berit</a></p></body></html>";
		string test_doc2 = "<html><head><title>arne</title></head><body bgcolor=\"#0f0\"><p>Arne</p><img src=\"http://i.rdw.se/c66.jpg\"><a href='http://i.rdw.se'>Berit</a></p></body></html>";
		
		webtest.view_string(test_doc, true);
		webtest.view_string(test_doc2, false);

		Gtk.main();

		return 0;
	}
}*/
