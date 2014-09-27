public class BrowserWebView : Gtk.ScrolledWindow {
	private WebKit.WebView webview;
	
	public signal void title_changed(string title);


	public bool go_forward() {
		this.webview.go_forward();
		return true;
	}

	public bool go_back() {
		this.webview.go_back();
		return true;
	}

	private void new_title(string title) {
		this.title_changed(title);
	}

	public BrowserWebView() {
		this.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
		this.webview = new WebKit.WebView();
		this.add(this.webview);
		this.show_all();
		this.webview.load_uri("http://google.se");
		this.webview.get_main_frame().title_changed.connect(this.new_title);
	}
}

