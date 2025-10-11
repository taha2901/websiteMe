// main.dart
// Static Flutter Web design demo (no backend logic)
// Copy this file to lib/main.dart in a Flutter project and run: flutter run -d chrome

import 'package:flutter/material.dart';

void main() {
  runApp(WebsiteMeDemo());
}

class WebsiteMeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebsiteMe - Flutter Web Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopNav(),
              HeroSection(),
              FeaturesSection(),
              GallerySection(),
              PricingSection(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// NAV
class TopNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.teal, Colors.green]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Text('WM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              SizedBox(width: 12),
              Text('WebsiteMe', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          Row(
            children: [
              NavButton(label: 'Features'),
              NavButton(label: 'Gallery'),
              NavButton(label: 'Pricing'),
              SizedBox(width: 12),
              OutlinedButton(onPressed: () {}, child: Text('Login')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: () {}, child: Text('Get Started')),
            ],
          )
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  NavButton({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(onPressed: () {}, child: Text(label, style: TextStyle(color: Colors.grey[800]))),
    );
  }
}

// HERO
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Beautiful, fast and modern websites', style: TextStyle(fontSize: width>800?40:28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Text('A static design demo built with Flutter for web. Responsive and simple — focus on visuals.', style: TextStyle(fontSize:16, color: Colors.grey[700])),
                    SizedBox(height: 24),
                    Row(children: [
                      ElevatedButton(onPressed: () {}, child: Padding(padding: EdgeInsets.symmetric(horizontal:18, vertical:14), child: Text('Start Free'))),
                      SizedBox(width: 12),
                      OutlinedButton(onPressed: () {}, child: Padding(padding: EdgeInsets.symmetric(horizontal:16, vertical:14), child: Text('Explore Templates')))
                    ]),
                    SizedBox(height: 20),
                    Row(children: [Metric(label:'Users', value:'1.2K'), SizedBox(width:24), Metric(label:'Templates', value:'24'), SizedBox(width:24), Metric(label:'Uptime', value:'99.9%')])
                  ],
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network('https://images.unsplash.com/photo-1521737604893-d14cc237f11d?q=80&w=1200&auto=format&fit=crop', height: 360, fit: BoxFit.cover),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Metric extends StatelessWidget {
  final String label;
  final String value;
  Metric({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(value, style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), Text(label, style: TextStyle(color: Colors.grey[600]))],
    );
  }
}

// FEATURES
class FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:40, horizontal:24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth:1100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FeatureCard(icon:'🧩', title:'Components', description:'Reusable headers, cards and galleries.'),
            FeatureCard(icon:'⚡', title:'Performance', description:'Fast static pages and optimized assets.'),
            FeatureCard(icon:'🎨', title:'Design', description:'Clean visual language and spacing.'),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String icon, title, description;
  FeatureCard({required this.icon, required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:8),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:6)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(icon, style: TextStyle(fontSize:28)),
          SizedBox(height:12),
          Text(title, style: TextStyle(fontSize:16, fontWeight: FontWeight.w600)),
          SizedBox(height:8),
          Text(description, style: TextStyle(color: Colors.grey[700])),
        ]),
      ),
    );
  }
}

// GALLERY
class GallerySection extends StatelessWidget {
  final List<String> images = [
    'https://images.unsplash.com/photo-1503264116251-35a269479413?q=80&w=900&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=900&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?q=80&w=900&auto=format&fit=crop',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.symmetric(vertical:40, horizontal:24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth:1100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Gallery', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold)),
          SizedBox(height:16),
          Wrap(spacing:16, runSpacing:16, children: images.map((url)=>GalleryImage(url:url)).toList())
        ]),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String url;
  GalleryImage({required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:6)]),
      child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(url, fit: BoxFit.cover)),
    );
  }
}

// PRICING
class PricingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:40, horizontal:24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth:1100),
        child: Column(children: [
          Text('Pricing', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold)),
          SizedBox(height:16),
          Row(children: [
            PricingCard(title:'Free', price:'\$0', bullets:['1 site','Community support']),
            PricingCard(title:'Pro', price:'\$12/mo', bullets:['Unlimited sites','Priority support']),
            PricingCard(title:'Enterprise', price:'Contact', bullets:['Custom plan','SLAs']),
          ])
        ]),
      ),
    );
  }
}

class PricingCard extends StatelessWidget {
  final String title, price;
  final List<String> bullets;
  PricingCard({required this.title, required this.price, required this.bullets});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:8),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:6)]),
        child: Column(children: [
          Text(title, style: TextStyle(fontSize:18, fontWeight: FontWeight.w600)),
          SizedBox(height:8),
          Text(price, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
          SizedBox(height:12),
          ...bullets.map((b)=>Row(children:[Icon(Icons.check,size:16,color:Colors.green),SizedBox(width:8),Expanded(child:Text(b))])).toList(),
          SizedBox(height:12),
          ElevatedButton(onPressed: () {}, child: Text('Choose'))
        ]),
      ),
    );
  }
}

// FOOTER
class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: EdgeInsets.symmetric(vertical:24, horizontal:24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth:1100),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('WebsiteMe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height:6),
            Text('© 2025 WebsiteMe. All rights reserved.', style: TextStyle(color: Colors.white70))
          ]),
          Row(children: [TextButton(onPressed: () {}, child: Text('Terms', style: TextStyle(color: Colors.white70))), SizedBox(width:12), TextButton(onPressed: () {}, child: Text('Privacy', style: TextStyle(color: Colors.white70)))])
        ]),
      ),
    );
  }
}
