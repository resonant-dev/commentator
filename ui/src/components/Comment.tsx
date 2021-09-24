import { format } from 'date-fns';
import type { CommentType } from '../types/comments';
import { classNames } from '../utils/style';

type Props = {
    first: boolean;
    comment: CommentType;
};

const Comment = ({
    first,
    comment: {
        id,
        attributes: { text, html },
    },
}: Props) => {
    return (
        <div className="ct-flex ct-text-sm ct-text-gray-500 ct-space-x-4">
            <div className="ct-flex-none ct-py-4">
                <img
                    src={
                        'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80'
                    }
                    alt=""
                    className="ct-p-0 ct-w-10 ct-h-10 ct-bg-gray-100 ct-rounded-full"
                />
                {/* <img src={avatarSrc} alt="" className="ct-w-10 ct-h-10 ct-bg-gray-100 ct-rounded-full" /> */}
            </div>
            <div className={classNames(first ? '' : 'ct-border-t ct-border-gray-200', 'ct-flex-1 ct-py-4')}>
                <h3 className="ct-font-medium ct-text-gray-900">{'User Name'}</h3>
                {/* <h3 className="ct-font-medium ct-text-gray-900">{user}</h3> */}
                <p>
                    <time dateTime={'datetime'}>{format(new Date(), 'MMM dd, yyyy')}</time>
                    {/* <time dateTime={datetime}>{date}</time> */}
                </p>

                <div
                    className="ct-mt-4 ct-prose ct-prose-sm ct-max-w-none ct-text-gray-500"
                    // eslint-disable-next-line react/no-danger
                    dangerouslySetInnerHTML={{ __html: text /*html*/ }}
                />
            </div>
        </div>
    );
};

export default Comment;
