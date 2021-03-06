@gtktype GtkWindow
function GtkWindow(title=nothing, w=-1, h=-1, resizable=true, toplevel=true)
    hnd = ccall((:gtk_window_new,libgtk),Ptr{GObject},(Enum,),
        toplevel?GtkWindowType.TOPLEVEL:GtkWindowType.POPUP)
    if title !== nothing
        ccall((:gtk_window_set_title,libgtk),Void,(Ptr{GObject},Ptr{Uint8}),hnd,title)
    end
    if resizable
        ccall((:gtk_window_set_default_size,libgtk),Void,(Ptr{GObject},Int32,Int32),hnd,w,h)
    else
        ccall((:gtk_window_set_resizable,libgtk),Void,(Ptr{GObject},Bool),hnd,false)
        ccall((:gtk_widget_set_size_request,libgtk),Void,(Ptr{GObject},Int32,Int32),hnd,w,h)
    end
    widget = GtkWindow(hnd)
    show(widget)
    widget
end

resize!(win::GtkWindowI, w::Integer, h::Integer) = ccall((:gtk_window_resize,libgtk),Void,(Ptr{GObject},Int32,Int32),win,w,h)

present(win::GtkWindowI) = ccall((:gtk_window_present,libgtk),Void,(Ptr{GObject},),win)

@gtktype GtkScrolledWindow
function GtkScrolledWindow()
    hnd = ccall((:gtk_scrolled_window_new,libgtk),Ptr{GObject},(Ptr{GObject},Ptr{GObject}),
                C_NULL,C_NULL)
    GtkScrolledWindow(hnd)
end

#GtkSeparator — A separator widget
