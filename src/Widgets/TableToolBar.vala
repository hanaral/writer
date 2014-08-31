/***
The MIT License (MIT)

Copyright (c) 2014 Tuur Dutoit

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
***/


using Gtk;
using Gdk;
using Granite.Widgets;

namespace Writer.Widgets {
    public class TableToolBar : Gtk.Toolbar {
    
        private Editor editor;
        public FontButton font_button;
        public ToggleButton bold_button;
        public ToggleButton italic_button;
        public ToggleButton underline_button;
        public ToggleButton strikethrough_button;
        public ModeButton align_button;
    
        public TableToolBar (Editor editor) {
            this.editor = editor;

            // TODO: Change to Gtk.PopOver
            var table_properties_button = new Gtk.Button.with_label ("Table Properties");
            var table_properties_item = new Gtk.ToolItem ();
                table_properties_item.add (table_properties_button);

            var font_item = new ToolItem ();
                font_button = new Gtk.FontButton ();
                font_button.use_font = true;
                font_button.use_size = true;
                font_button.font_set.connect (() => {
                    unowned string name = font_button.get_font_name ();
                    stdout.printf ("Selected font: %s\n", name);
                });
                font_item.add (font_button);

            var font_color_button = new Gtk.ColorButton ();
                font_color_button.use_alpha = false;
            var font_color_item = new Gtk.ToolItem ();
                font_color_item.add (font_color_button);
                
            var styles_item = new ToolItem ();
                var styles_buttons = new ButtonGroup ();
                    bold_button = new Gtk.ToggleButton ();
                        bold_button.add (new Image.from_icon_name ("format-text-bold-symbolic", Gtk.IconSize.BUTTON));
                        bold_button.focus_on_click = false;
                        styles_buttons.pack_start (bold_button);
                    italic_button = new Gtk.ToggleButton ();
                        italic_button.add (new Image.from_icon_name ("format-text-italic-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (italic_button);
                    underline_button = new Gtk.ToggleButton ();
                        underline_button.add (new Image.from_icon_name ("format-text-underline-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (underline_button);
                    strikethrough_button = new Gtk.ToggleButton ();
                        strikethrough_button.add (new Image.from_icon_name ("format-text-strikethrough-symbolic", Gtk.IconSize.BUTTON));
                        styles_buttons.pack_start (strikethrough_button);
                styles_item.add (styles_buttons);
                
            var align_item = new ToolItem ();
                align_button = new ModeButton ();
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-left-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-center-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-right-symbolic", Gtk.IconSize.BUTTON));
                    align_button.append (new Gtk.Button.from_icon_name ("format-justify-fill-symbolic", Gtk.IconSize.BUTTON));
                align_item.add (align_button);

            var add_table_button = new Gtk.Button.with_label ("Add");
            var add_table_item = new Gtk.ToolItem ();
                add_table_item.add (add_table_button);

            var delete_table_button = new Gtk.Button.with_label ("Delete");
            var delete_table_item = new Gtk.ToolItem ();
                delete_table_item.add (delete_table_button);
            
            
            this.add (table_properties_item);
            this.add (font_item);
            this.add (font_color_item);
            this.add (styles_item);
            this.add (align_item);
            this.add (add_table_item);
            this.add (delete_table_item);
            
            align_button.mode_changed.connect (() => {
                change_align (align_button.selected);
            });
            
            bold_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("bold");
                return false;
            });
            italic_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("italic");
                return false;
            });
            underline_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("underline");
                return false;
            });
            strikethrough_button.button_press_event.connect ((event) => {
                if (event.type == EventType.BUTTON_PRESS)
                    editor.toggle_style ("strikethrough");
                return false;
            });
            
        }
        
        public void change_align (int index) {
            switch (index) {
                case 1:
                    editor.set_justification ("center"); break;
                case 2:
                    editor.set_justification ("right"); break;
                case 3:
                    editor.set_justification ("fill"); break;
                default:
                    editor.set_justification ("left"); break;
            }
        }

    }
}