

//const functions = require('firebase-functions');
//const stripe = require('stripe')('sk_test_51Oe0hJFXbiqZ9ZYFutNmvhfnGTP31xnVzPiF9Pl8PO8yE85pG6xfV5VnKlgYGIEnUnScjMysWhJ5LQW94oFoOpIL00hqgQ8tt9');
//
//exports.createAccountAndGetLink = functions.https.onRequest(async (req, res) => {
//    try {
//        const account = await stripe.accounts.create({
//            type: 'custom',
//            country: 'US',
//            email: 'jenny.rosen@example.com',
//            capabilities: {
//                card_payments: {
//                    requested: true,
//                },
//                transfers: {
//                    requested: true,
//                },
//            },
//        });
//
//        // Generate the account onboarding link
//        const accountLink = await stripe.accountLinks.create({
//            account: account.id,
//            refresh_url: 'YOUR_REFRESH_URL', // Provide your refresh URL
//            return_url: 'YOUR_RETURN_URL', // Provide your return URL
//            type: 'account_onboarding',
//        });
//
//        res.json({ url: accountLink.url });
//    } catch (error) {
//        console.error('Error creating account:', error);
//        res.status(500).json({ error: 'Failed to create account' });
//    }
//});
