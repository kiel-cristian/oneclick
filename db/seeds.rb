#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
Category.create(name: 'Deportes')
Category.create(name: 'Entretencion')
Category.create(name: 'Familia')
Category.create(name: 'Computacion')
Category.create(name: 'Salud')
Category.create(name: 'Belleza')
Category.create(name: 'Turismo')
Category.create(name: 'Ciencias')
Category.create(name: 'Artes Visuales')
Category.create(name: 'Musica')
Category.create(name: 'Otros')

Denunce.delete_all
Denunce.create(type: 'Inválido',description: 'La URL no existe, o dejo de existir')
Denunce.create(type: 'Phishing',description: 'La URL apunta a un posible sitio de phishing')
Denunce.create(type: 'Virus',description: 'La URL apunta a un sitio con contenido dañino')
Denunce.create(type: 'Inadecuado',description: 'La URL apunta a un sitio de contenidos para adultos')
Denunce.create(type: 'Piratería',description: 'La URL apunta a un sitio que atenta contra derechos de autor')
Denunce.create(type: 'Otro',description: 'La URL se sospecha insegura por otras causas')


