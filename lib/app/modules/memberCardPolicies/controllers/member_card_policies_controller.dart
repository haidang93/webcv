import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberCardPoliciesController extends GetxController {
  ScrollController scrollController = ScrollController();
  //TODO: Implement MemberCardPoliciesController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

String termOfService = '''

If you require any more information or have any questions about our Terms of Service, please feel free to contact me by email to dannynguyen.vnn@gmail.com.

Introduction
These terms and conditions govern your use of this app; by using this app, you accept these terms and conditions in full and without reservation. If you disagree with these terms and conditions or any part of these terms and conditions, you must not use this app.

By using this platform and by agreeing to these terms and conditions.

License to use platform
Unless otherwise stated, and/or its licensors own the intellectual property rights published on this platform and materials used on. Subject to the license below, all these intellectual property rights are reserved.

You may view, download for caching purposes only, and print pages, files or other content from the platform for your own personal use, subject to the restrictions set out below and elsewhere in these terms and conditions.

Acceptable use
You must not use this platform in any way that causes, or may cause, damage to the platform or impairment of the availability or accessibility of or in any way which is unlawful, illegal, fraudulent or harmful, or in connection with any unlawful, illegal, fraudulent or harmful purpose or activity.

You must not use this platform to copy, store, host, transmit, send, use, publish or distribute any material which consists of (or is linked to) any spyware, computer virus, Trojan horse, worm, keystroke logger, rootkit or other malicious computer software.

You must not conduct any systematic or automated data collection activities on or in relation to this platform without Cards' express written consent.
This includes:

scraping
data mining
data extraction
data harvesting
'framing' (iframes)
Article 'Spinning'
You must not use this platform or any part of it to transmit or send unsolicited commercial communications.

You must not use this platform for any purposes related to marketing without the express written consent of .

If provides you with a user ID and password to enable you to access restricted areas of this platform or other content or services, you must ensure that the user ID and password are kept confidential. You alone are responsible for your password and user ID security..

may disable your user ID and password at Cards' sole discretion without notice or explanation.

User content
In these terms and conditions, “your user content” means material (including without limitation text, images, audio material, video material and audio-visual material) that you submit to this platform, for whatever purpose.

You grant to a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate and distribute your user content in any existing or future media. You also grant to the right to sub-license these rights, and the right to bring an action for infringement of these rights.

Your user content must not be illegal or unlawful, must not infringe any third party's legal rights, and must not be capable of giving rise to legal action whether against you or or a third party (in each case under any applicable law).

You must not submit any user content to the platform that is or has ever been the subject of any threatened or actual legal proceedings or other similar complaint.

reserves the right to edit or remove any material submitted to this platform, or stored on the servers of , or hosted or published upon this platform.

's rights under these terms and conditions in relation to user content, does not undertake to monitor the submission of such content to, or the publication of such content on, this platform.

No warranties
This platform is provided “as is” without any representations or warranties, express or implied. makes no representations or warranties in relation to this platform or the information and materials provided on this platform.

Without prejudice to the generality of the foregoing paragraph, does not warrant that:

this platform will be constantly available, or available at all; or
the information on this platform is complete, true, accurate or non-misleading.
Nothing on this platform constitutes, or is meant to constitute, advice of any kind. If you require advice in relation to any legal, financial or medical matter you should consult an appropriate professional.

Limitations of liability
will not be liable to you (whether under the law of contact, the law of torts or otherwise) in relation to the contents of, or use of, or otherwise in connection with, this platform:

to the extent that the platform is provided free-of-charge, for any direct loss;
for any indirect, special or consequential loss; or
for any business losses, loss of revenue, income, profits or anticipated savings, loss of contracts or business relationships, loss of reputation or goodwill, or loss or corruption of information or data.
These limitations of liability apply even if has been expressly advised of the potential loss.

Exceptions
Nothing in this platform disclaimer will exclude or limit any warranty implied by law that it would be unlawful to exclude or limit; and nothing in this platform disclaimer will exclude or limit the liability of in respect of any:

death or personal injury caused by the negligence of or its agents, employees or shareholders/owners;
fraud or fraudulent misrepresentation on the part of ; or
matter which it would be illegal or unlawful for to exclude or limit, or to attempt or purport to exclude or limit, its liability.
Reasonableness
By using this platform, you agree that the exclusions and limitations of liability set out in this platform disclaimer are reasonable.

If you do not think they are reasonable, you must not use this platform.

Other parties
You accept that, as a limited liability entity, has an interest in limiting the personal liability of its officers and employees. You agree that you will not bring any claim personally against 's officers or employees in respect of any losses you suffer in connection with the platform.

Without prejudice to the foregoing paragraph, you agree that the limitations of warranties and liability set out in this platform disclaimer will protect 's officers, employees, agents, subsidiaries, successors, assigns and sub-contractors as well as .

Unenforceable provisions
If any provision of this platform disclaimer is, or is found to be, unenforceable under applicable law, that will not affect the enforceability of the other provisions of this platform disclaimer.

Indemnity
You hereby indemnify and undertake to keep indemnified against any losses, damages, costs, liabilities and expenses (including without limitation legal expenses and any amounts paid by to a third party in settlement of a claim or dispute on the advice of 's legal advisers) incurred or suffered by arising out of any breach by you of any provision of these terms and conditions, or arising out of any claim that you have breached any provision of these terms and conditions.

Breaches of these terms and conditions
Without prejudice to 's other rights under these terms and conditions, if you breach these terms and conditions in any way, may take such action as deems appropriate to deal with the breach, including suspending your access to the platform, prohibiting you from accessing the platform, blocking computers using your IP address from accessing the platform, contacting your internet service provider to request that they block your access to the platform and/or bringing court proceedings against you.

Variation
may revise these terms and conditions from time-to-time. Revised terms and conditions will apply to the use of this platform from the date of the publication of the revised terms and conditions on this platform. Please check this page regularly to ensure you are familiar with the current version.

Assignment
may transfer, sub-contract or otherwise deal with Cards' rights and/or obligations under these terms and conditions without notifying you or obtaining your consent.

You may not transfer, sub-contract or otherwise deal with your rights and/or obligations under these terms and conditions.

Severability
If a provision of these terms and conditions is determined by any court or other competent authority to be unlawful and/or unenforceable, the other provisions will continue in effect. If any unlawful and/or unenforceable provision would be lawful or enforceable if part of it were deleted, that part will be deemed to be deleted, and the rest of the provision will continue in effect.

Entire agreement
These terms and conditions, together with Cards' Privacy Policy constitute the entire agreement between you and in relation to your use of this platform, and supersede all previous agreements in respect of your use of this platform.

Law and jurisdiction
These terms and conditions will be governed by and construed in accordance with the laws of , and any disputes relating to these terms and conditions will be subject to the exclusive jurisdiction of the courts of .''';
String privacyPolicy = '''

This privacy policy has been compiled to better serve those who are concerned with how their 'Personally Identifiable Information' (PII) is being used. PII, as used in me privacy law and information security, is information that can be used on its own or with other information to identify, contact, or locate a single person, or to identify an individual in context. Please read our privacy policy carefully to get a clear understanding of how we collect, use, protect or otherwise handle your Personally Identifiable Information in accordance with Cards platform.

What personal information do we collect from the people that use Member Cards?

Upon creating a new Cards account, as appropriate, you may be asked to enter your full name, email address, phone number, birth date, home address or other details to help you with your experience.

What technical or meta data do we collect from the people that use Cards?

Network information, phone (or other appliance that runs Member Cards) hardware and software information and values.

When do we collect information?

We collect information from you when you register or use on our app, website or any other platform extensions.

How do we use your information?

We may use the information we collect from you when you register, use the Cards app platform or any extensions, transfer a digital card, pair a digital card or use certain other platform features in the following ways:

      • To personalize user's experience and to allow me to deliver the type of content and product offerings in which you are most interested.
      • To improve our platform in order to better serve you.
      • To allow me to better service you in responding to your customer service requests.
      • To administer a contest, promotion, survey or other site feature.
      • To quickly process your transactions.
      • To send periodic emails or notifications regarding your orders, transactions or other products and services.

How do we protect visitor information?

Our platform is thoroughly scanned on a regular basis for security holes, known and unknown vulnerabilities in order to make our platform as safe as possible.

All of our systems are encrypted, both at transfer and at rest with popular and proprietary encryption algorithms, exceeding the current security standard of digital wallets.

Your personal information is contained behind secured networks and is only accessible by a stricly limited number of persons who have special access rights to such systems, and are required to keep the information confidential. Note all direct access to Cards systems is strictly audited, recorded and logged. Highly sensitive information, as defined by our strict internal secret security policy, is not accessible by anyone at Cards. In addition, all sensitive/credit/transactional information you supply is encrypted via Secure Socket Layer (SSL) technology at transfer, alongside with other proprietary encryption techniques.

We implement a variety of security measures when a user places an order enters, submits, or accesses their information to maintain the safety of your personal information.

We collect your email address in order to:
      • Send information, respond to inquiries, and/or other requests or questions.
      • Process transactions and to send information and updates pertaining to transactions
      • We may also send you additional information related to your product and/or service.
      • Market to our mailing list or continue to send emails to our clients after the original transaction has occurred

To be in accordance with CANSPAM we agree to the following:
      • NOT use false, or misleading subjects or email addresses
      • Identify the message as an advertisement in some reasonable way
      • Include the physical address of our business or site headquarters
      • Monitor third party email marketing services for compliance, if one is used.
      • Honor opt-out/unsubscribe requests quickly
      • Allow users to unsubscribe by using the link at the bottom of each email

If at any time you would like to unsubscribe from receiving future emails, you can
      • Follow the instructions at the bottom of each email.
and we will promptly remove you from ALL correspondence.


Contacting me

Due to a high volume of contact requests, we accept emails only: dannynguyen.vnn@gmail.com

Last Edited on 2021-07-01''';
