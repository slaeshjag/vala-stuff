public class DorisWindow : Gtk.Window {
	BrowserWebView webview;
	public Gtk.AccelGroup acc;

	private void set_window_title(string title) {
		this.title = title;
	}

	private void add_accelerators() {
		this.acc.connect(Gdk.keyval_from_name("L"), Gdk.ModifierType.CONTROL_MASK, Gtk.AccelFlags.VISIBLE, () => webview.go_forward());
		this.acc.connect(Gdk.keyval_from_name("H"), Gdk.ModifierType.CONTROL_MASK, Gtk.AccelFlags.VISIBLE, () => webview.go_back());
	}

	public DorisWindow() {
		this.webview = new BrowserWebView();
		this.title = "Doris";
		this.add(this.webview);
		this.show_all();

		this.acc = new Gtk.AccelGroup();
		this.add_accel_group(this.acc);
		this.add_accelerators();
		this.webview.title_changed.connect(set_window_title);
	}
}
