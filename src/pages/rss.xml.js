import rss from '@astrojs/rss';
import sanitizeHtml from 'sanitize-html';

import {
    SITE_TITLE,
    SITE_DESCRIPTION,
} from "../config";

export async function get(context) {
    const posts = Object.values(
        import.meta.glob(
            './blog/posts/*.{md,mdx}',
            {
                eager: true
            }
        )
    );

    return rss({
        title: SITE_TITLE,
        description: SITE_DESCRIPTION,
        site: context.site,
        items: posts.map((post) => ({
            link: post.url,
            content: sanitizeHtml(post.compiledContent()),
            ...post.frontmatter,
        })),
        customData: `<language>en-us</language>`,
        stylesheet: '/rss/styles.xsl',
    });
}