
public class MailWebComposeToolbar : Gtk.Toolbar {
	public Gtk.ToolButton bold;
	public Gtk.ToolButton italic;
	public Gtk.ToolButton underline;
	
	public MailWebComposeToolbar() {
		this.set_style(Gtk.ToolbarStyle.ICONS);
		bold = new Gtk.ToolButton.from_stock(Gtk.Stock.BOLD);
		italic = new Gtk.ToolButton.from_stock(Gtk.Stock.ITALIC);
		underline = new Gtk.ToolButton.from_stock(Gtk.Stock.UNDERLINE);
		this.add(bold);
		this.add(italic);
		this.add(underline);

		this.show_all();
	}
}


public class MailWebCompose : Gtk.VBox {
	private MailWebView mailview;
	private MailWebComposeToolbar toolbar;
	private WebKit.DOMDocument dom_doc;

	public MailWebCompose(string content) {
			this.mailview = new MailWebView();
			this.toolbar = new MailWebComposeToolbar();
			this.mailview.view_string(content, true);
			this.mailview.webview.set_editable(true);
			this.pack_start(this.toolbar, false, false, 0);
			this.add(this.mailview);
			this.show_all();
			this.dom_doc = mailview.webview.get_dom_document();
	}

}


class test : GLib.Object {
	public static int main(string[] args) {
		Gtk.init(ref args);
		var window = new Gtk.Window();
		var compose = new MailWebCompose("");
		window.add(compose);
		window.show_all();

		Gtk.main();

		return 0;
	}
}
