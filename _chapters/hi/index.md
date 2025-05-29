---
layout: default
title: भगवद गीता
permalink: /:path/
lang: hi
---

<h1>श्रीमद्भगवद्गीता</h1>

<!-- Language switch -->

{% assign lang = page.url | split: '/' | slice: 1 %} {% assign page_path =
page.url | remove_first: '/' | remove_first: lang | prepend: '/' %}

<p>
  <strong>Language:</strong>
  {% unless lang == 'en' %}
    <a href="{{ site.baseurl }}/en">English</a>
  {% else %}
    English
  {% endunless %} |
  {% unless lang == 'hi' %}
    <a href="{{ site.baseurl }}/hi">हिंदी</a>
  {% else %}
    हिंदी
  {% endunless %} |
  {% unless lang == 'sa' %}
    <a href="{{ site.baseurl }}/sa">संस्कृत</a>
  {% else %}
    संस्कृत
  {% endunless %}
</p>

<!-- Chapters -->

<div class="chapters-list">
  {% assign chapters = site.data.chapters %} {% assign verses = site.data.verses
  %} {% assign translations = site.data.translations | where: "authorName",
  "Swami Ramsukhdas" %} {% for chapter in chapters %}
  <details class="chapter-dropdown">
    <summary>
      <strong>{{ chapter.chapter_number }}. {{ chapter.name }}</strong>
      ({{ chapter.name_meaning }})
    </summary>
    <div class="chapter-summary">
      <p>{{ chapter.chapter_summary_hindi }}</p>
    </div>

    <ul class="verses-list">
      {% for verse in verses %} {% if verse.chapter_id == chapter.id %} {%
      assign trans = translations | where: "verse_id", verse.id | first %} {% if
      trans %}
      <li>
        Verse {{ verse.verse_number }}: {{ trans.description }}

      </li>
      {% endif %} {% endif %} {% endfor %}
    </ul>

  </details>
  {% endfor %}
</div>

<style>
  .chapter-dropdown {
    margin-bottom: 1em;
    border: 1px solid #ccc;
    padding: 0.5em;
    border-radius: 6px;
  }

  .chapter-summary {
    margin-top: 0.5em;
    font-style: italic;
    color: #555;
  }

  .verses-list {
    margin-top: 1em;
    padding-left: 1em;
  }

  .verses-list li {
    margin-bottom: 0.4em;
  }

  a {
    text-decoration: none;
    color: #1a73e8;
  }

  a:hover {
    text-decoration: underline;
  }
</style>
