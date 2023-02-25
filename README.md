# A Real-Time ServerSentEvent Server Written in V

[V](https://vlang.io) is an easy, ridiculously fast and minimalist language.

## Installation

You should first [install V on you system](https://vlang.io/), it's very easy and standalone or run `v up` to update it if you had played with it a while ago.

Then run the following:

```
git clone https://github.com/vinyll/V-Server-Sent-Event.git
cd V-Server-Sent-Event
v run src
```

Your server will be running on port _8081_.

This is just a V test on running a minimalist self-hosted real-time [ServerSentEvent](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events) app.

## Usage

I use [HTTPie]() but anything down to cURL would do.

Read the full thread:
```
http :8081
```

Add a comment and get the updated thread:
```
http post :8081/message author="bob" body="Imagine all the people living life in peace 🕊️"
```
