module main

import vweb
import os
import time
import json

struct App {
	vweb.Context
    mut: thread      []Message
}

struct Object {
	title       string
	description string
}

struct Message {
	author          string
    body            string
    mut: datetime   time.Time
}

fn main() {
	vweb.run_at(new_app(), vweb.RunParams{
		port: 8081
	}) or { panic(err) }
}

fn new_app() &App {
	mut app := &App{}
	// makes all static files available.
	app.mount_static_folder_at(os.resource_abs_path('.'), '/')
	return app
}

['/']
pub fn (mut app App) page_home() !vweb.Result {
    thread := json.decode([]Message, os.read_file("thread.json")!)!
    return app.ok(json.encode(thread))
}

['/message'; post]
pub fn (mut app App) send_message() !vweb.Result {
    mut message := json.decode(Message, app.req.data)!
    message.datetime = time.now()

    mut thread := json.decode([]Message, os.read_file("thread.json")!)!
    thread << message
    os.write_file("thread.json", json.encode_pretty(thread))!

	app.set_content_type(app.req.header.get(.content_type) or { '' })
	return app.ok(json.encode(thread))
}
