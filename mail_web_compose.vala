
public class MailWebComposeToolbar : Gtk.Toolbar {
	public Gtk.ToggleToolButton bold;
	public Gtk.ToggleToolButton italic;
	public Gtk.ToggleToolButton underline;
	public Gtk.ToggleToolButton source;
	
	public MailWebComposeToolbar() {
		this.set_style(Gtk.ToolbarStyle.ICONS);
		bold = new Gtk.ToggleToolButton.from_stock(Gtk.Stock.BOLD);
		italic = new Gtk.ToggleToolButton.from_stock(Gtk.Stock.ITALIC);
		underline = new Gtk.ToggleToolButton.from_stock(Gtk.Stock.UNDERLINE);
		source = new Gtk.ToggleToolButton.from_stock(Gtk.Stock.EXECUTE);
		this.add(bold);
		this.add(italic);
		this.add(underline);
		this.add(source);

		this.show_all();
	}
}


public class MailWebCompose : Gtk.VBox {
	private MailWebView mailview;
	private MailWebComposeToolbar toolbar;
	private WebKit.DOMDocument dom_doc;
	private string head;

	private void toggle_sourceview() {
		string code;

		if (this.toolbar.source.get_active()) {
			mailview.webview.set_editable(false);
		}

		this.dom_doc = mailview.webview.get_dom_document();

		/* Only unformatted get text when returning from view source code mode */
		if (this.toolbar.source.get_active()) {
			code = this.dom_doc.body.get_outer_html();
			this.head = this.dom_doc.head.get_outer_html();
		} else
			code = this.dom_doc.body.get_outer_text();

		this.mailview.view_string(head + code, true, this.toolbar.source.get_active());

		if (this.toolbar.source.get_active()) {
			mailview.webview.set_editable(true);
		}
		

	}

	private void connect_toolbar() {
		this.toolbar.source.toggled.connect(toggle_sourceview);
	}

	public MailWebCompose(string content) {
		this.mailview = new MailWebView();
		this.toolbar = new MailWebComposeToolbar();
		this.mailview.view_string(content, true, false);
		this.mailview.webview.set_editable(true);
		this.pack_start(this.toolbar, false, false, 0);
		this.mailview.follow_links = false;
		this.add(this.mailview);
		this.show_all();
		this.dom_doc = mailview.webview.get_dom_document();

		this.connect_toolbar();
	}

}


int main(string[] args) {
	Gtk.init(ref args);
	var window = new Gtk.Window();
	var compose = new MailWebCompose("<html><body><p><b>Arne</b></p></body></html>");
	window.add(compose);
	window.show_all();

	Gtk.main();

	return 0;
}

